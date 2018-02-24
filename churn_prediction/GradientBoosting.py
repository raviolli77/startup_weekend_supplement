#!/usr/bin/env python3
import time
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.utils import resample
from sklearn.metrics import auc
from sklearn.metrics import roc_curve
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold, cross_val_score
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import GradientBoostingClassifier

customer_churn = pd.read_csv('customer-churn.csv')

names = ["gender", "Partner", "Dependents", "PhoneService", 
"MultipleLines", "InternetService", "OnlineSecurity",
"OnlineBackup", "DeviceProtection", "TechSupport", 
"StreamingMovies", "StreamingTV", "Contract", "PaperlessBilling", 
"PaymentMethod"]

churn = ["Continuing Service", "Churn"]

customer_churn_new = pd.get_dummies(customer_churn, columns=names)
del customer_churn_new['customerID'] 

customer_churn_new["Churn"] = customer_churn_new["Churn"].map({'Yes':1, "No":0})

customer_churn_new["TotalCharges"] = customer_churn_new["TotalCharges"].replace(" ", np.nan)
customer_churn_new["TotalCharges"] = customer_churn_new["TotalCharges"].astype("float64")
customer_churn_new["TotalCharges"].fillna(customer_churn_new["TotalCharges"].mean(), inplace=True)

sub_set, test_set = train_test_split(customer_churn_new,
                                          test_size = 0.25,
                                          random_state = 42)

# UPSAMPLING
training_set, validation_set = train_test_split(sub_set,
                                          test_size = 0.15,
                                          random_state = 42)

training_majority = training_set[training_set["Churn"] == 0]

training_minority = training_set[training_set["Churn"] == 1]

training_match = resample(training_minority, 
                          n_samples=3320,
                          replace=True, 
                          random_state=42)


training_set_final = pd.concat([training_majority, training_match])

# NEW TRAINING SET
feature_space = training_set_final.iloc[:, training_set_final.columns != "Churn"]
feature_class = training_set_final.iloc[:, training_set_final.columns == "Churn"]


fit_gb = GradientBoostingClassifier(random_state=42,
                                    n_estimators=500)

fit_gb.set_params(learning_rate=0.3, 
                  max_depth=3, 
                  loss="deviance", 
                  max_features="auto")

fit_gb.fit(feature_space, feature_class["Churn"])

test_set_feat = test_set.iloc[:, test_set.columns != "Churn"]
test_class_set = test_set.iloc[:, test_set.columns == "Churn"]

predictions_prob = fit_gb.predict_proba(test_set_feat)[:, 1]

# ROC Curve stuff
fpr2, tpr2, _ = roc_curve(test_class_set["Churn"],
    predictions_prob)

auc_gb = auc(fpr2, tpr2)
Multi-service web app with full automated piepline.

Platform: GCP, GKE+Helm  
WebApp: Flask, Docker    
Version control: GitHub  
CI/CD: GitHub Actions  
GitOps: ArgoCD  


K8s cluster and ArgoCD is running:  
<img width="735" height="435" alt="image" src="https://github.com/user-attachments/assets/e1dfe458-4f3d-4798-838d-c9b0dadc2bf5" />  
<img width="807" height="870" alt="image" src="https://github.com/user-attachments/assets/cab61773-4a1e-4d3d-a528-9ae97b53b677" />  



Application (Flask) Image built using Docker and it's running in Helm release in K8s(GKE):

<img width="312" height="46" alt="image" src="https://github.com/user-attachments/assets/520532c7-4924-4a47-99c5-5290464ede51" />  



GitHub Actions configured and tested (with automatic tag replacement in helm charts):
<img width="810" height="742" alt="image" src="https://github.com/user-attachments/assets/3fab549d-592f-4ad2-a6b4-60e26cdf51a3" />  



ArgoCD configured for GitOps:
<img width="1030" height="261" alt="image" src="https://github.com/user-attachments/assets/79a7a9ce-598e-4519-a4d7-99eb6a13eb85" />  

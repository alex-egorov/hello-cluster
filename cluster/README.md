    - name: Deploy
      run: |-
        kustomize edit set image gcr.io/PROJECT_ID/IMAGE=gcr.io/$PROJECT_ID/$IMAGE:${GITHUB_REF#refs/heads/}-$GITHUB_SHA
        kustomize build . | kubectl apply -f -
        kubectl rollout status deployment $IMAGE
        kubectl get services -o wide

    - name: Deploy
      run: |-
        kustomize edit set image gcr.io/PROJECT_ID/IMAGE=gcr.io/$PROJECT_ID/$IMAGE:${GITHUB_REF#refs/heads/}-$GITHUB_SHA
        kustomize build . | kubectl apply -f -
        kubectl rollout status deployment $IMAGE
        kubectl get services -o wide


${GITHUB_REF#refs/heads/} will be the branch name.

kustomize edit set namespace ${GITHUB_REF#refs/heads/}

kubectl create namespace ${GITHUB_REF#refs/heads/} || true

kubectl config set-context --current --namespace=${GITHUB_REF#refs/heads/}

    - name: Deploy
      run: |-
        kubectl create namespace ${GITHUB_REF#refs/heads/} || true
        kubectl config set-context --current --namespace=${GITHUB_REF#refs/heads/}
        kustomize edit set namespace ${GITHUB_REF#refs/heads/}
        kustomize edit set image gcr.io/PROJECT_ID/IMAGE=gcr.io/$PROJECT_ID/$IMAGE:${GITHUB_REF#refs/heads/}-$GITHUB_SHA
        kubectl apply -k .
        kubectl rollout status deployment $IMAGE



```
kustomize edit add annotation appVersion:$image_tag
```
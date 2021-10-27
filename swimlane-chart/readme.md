# Kubernetes options
I've added some things using some avaliable kubernetes options such as:
- **PodDisruptionBudgets**
This allows us to tolerate node upgrades or rolling updates, or if we need to taint a node and want to ensure that all running instances don't go down concurrently 
- **Soft Antiaffinity**
Keying off the hostname label in kubernetes, this allows us to split out the pods to as many different nodes as possible, but won't prevent a deployment if that's not possible.
- **securityContext**
Avoiding the default kubernetes user and making sure each container is running on it's own has security benefits, as well as preventing priv escalation
- **Autoscaling**
Added an HPA resource to autoscale based off of CPU metrics, would need tweaking in the real world to match what traffic is expected / load tests.
- **livenessProbes / ReadinessProbes**
I added really basic TCP checks for probes, these will need to be node level health checks before it gets into prod preferably, but it's a requirement for anything running in kubernetes in my opinion. StartupProbes are also a good value when pods take a decent amount of time to start. 


# Tools used
I'm using helmfile on top of helm, it enables us to string together multiple charts, and a big feature is its ability to split out environments (dev/stage/prod) as well as giving us a nice wrapper around helm diff, sops, and other plugins. 

# Commands used
```
helmfile diff
helmfile apply
```

# Command History and resource output

## Helmfile Apply
```
~/Documents/swimlane/swimlane-chart 10s
(do-sfo3-k8s-swimlane)❯ helmfile apply
Adding repo bitnami https://charts.bitnami.com/bitnami
"bitnami" has been added to your repositories

Building dependency release=swimlane, chart=../swimlane-chart
Comparing release=mongodb, chart=bitnami/mongodb
********************

	Release was not present in Helm.  Diff will show entire contents as new.

********************
default, mongodb, Deployment (apps) has been added:
-
+ # Source: mongodb/templates/standalone/dep-sts.yaml
+ apiVersion: apps/v1
+ kind: Deployment
+ metadata:
+   name: mongodb
+   namespace: default
+   labels:
+     app.kubernetes.io/name: mongodb
+     helm.sh/chart: mongodb-10.28.4
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/managed-by: Helm
+     app.kubernetes.io/component: mongodb
+ spec:
+   replicas: 1
+   strategy:
+     type: Recreate
+   selector:
+     matchLabels:
+       app.kubernetes.io/name: mongodb
+       app.kubernetes.io/instance: mongodb
+       app.kubernetes.io/component: mongodb
+   template:
+     metadata:
+       labels:
+         app.kubernetes.io/name: mongodb
+         helm.sh/chart: mongodb-10.28.4
+         app.kubernetes.io/instance: mongodb
+         app.kubernetes.io/managed-by: Helm
+         app.kubernetes.io/component: mongodb
+     spec:
+
+       serviceAccountName: mongodb
+       affinity:
+         podAffinity:
+
+         podAntiAffinity:
+           preferredDuringSchedulingIgnoredDuringExecution:
+             - podAffinityTerm:
+                 labelSelector:
+                   matchLabels:
+                     app.kubernetes.io/name: mongodb
+                     app.kubernetes.io/instance: mongodb
+                     app.kubernetes.io/component: mongodb
+                 namespaces:
+                   - "default"
+                 topologyKey: kubernetes.io/hostname
+               weight: 1
+         nodeAffinity:
+
+       securityContext:
+         fsGroup: 1001
+         sysctls: []
+       containers:
+         - name: mongodb
+           image: docker.io/bitnami/mongodb:4.4.10-debian-10-r11
+           imagePullPolicy: "IfNotPresent"
+           securityContext:
+             runAsNonRoot: true
+             runAsUser: 1001
+           env:
+             - name: BITNAMI_DEBUG
+               value: "false"
+             - name: MONGODB_ROOT_USER
+               value: "root"
+             - name: MONGODB_ROOT_PASSWORD
+               valueFrom:
+                 secretKeyRef:
+                   name: mongodb
+                   key: mongodb-root-password
+             - name: ALLOW_EMPTY_PASSWORD
+               value: "no"
+             - name: MONGODB_SYSTEM_LOG_VERBOSITY
+               value: "0"
+             - name: MONGODB_DISABLE_SYSTEM_LOG
+               value: "no"
+             - name: MONGODB_DISABLE_JAVASCRIPT
+               value: "no"
+             - name: MONGODB_ENABLE_JOURNAL
+               value: "yes"
+             - name: MONGODB_ENABLE_IPV6
+               value: "no"
+             - name: MONGODB_ENABLE_DIRECTORY_PER_DB
+               value: "no"
+           ports:
+             - name: mongodb
+               containerPort: 27017
+           livenessProbe:
+             exec:
+               command:
+                 - mongo
+                 - --disableImplicitSessions
+                 - --eval
+                 - "db.adminCommand('ping')"
+             initialDelaySeconds: 30
+             periodSeconds: 10
+             timeoutSeconds: 5
+             successThreshold: 1
+             failureThreshold: 6
+           readinessProbe:
+             exec:
+               command:
+                 - bash
+                 - -ec
+                 - |
+                   # Run the proper check depending on the version
+                   [[ $(mongo --version | grep "MongoDB shell") =~ ([0-9]+\.[0-9]+\.[0-9]+) ]] && VERSION=${BASH_REMATCH[1]}
+                   . /opt/bitnami/scripts/libversion.sh
+                   VERSION_MAJOR="$(get_sematic_version "$VERSION" 1)"
+                   VERSION_MINOR="$(get_sematic_version "$VERSION" 2)"
+                   VERSION_PATCH="$(get_sematic_version "$VERSION" 3)"
+                   if [[ "$VERSION_MAJOR" -ge 4 ]] && [[ "$VERSION_MINOR" -ge 4 ]] && [[ "$VERSION_PATCH" -ge 2 ]]; then
+                       mongo --disableImplicitSessions $TLS_OPTIONS --eval 'db.hello().isWritablePrimary || db.hello().secondary' | grep -q 'true'
+                   else
+                       mongo --disableImplicitSessions $TLS_OPTIONS --eval 'db.isMaster().ismaster || db.isMaster().secondary' | grep -q 'true'
+                   fi
+             initialDelaySeconds: 5
+             periodSeconds: 10
+             timeoutSeconds: 5
+             successThreshold: 1
+             failureThreshold: 6
+           resources:
+             limits: {}
+             requests: {}
+           volumeMounts:
+             - name: datadir
+               mountPath: /bitnami/mongodb
+               subPath:
+       volumes:
+         - name: datadir
+           persistentVolumeClaim:
+             claimName: mongodb
default, mongodb, PersistentVolumeClaim (v1) has been added:
-
+ # Source: mongodb/templates/standalone/pvc.yaml
+ kind: PersistentVolumeClaim
+ apiVersion: v1
+ metadata:
+   name: mongodb
+   namespace: default
+   labels:
+     app.kubernetes.io/name: mongodb
+     helm.sh/chart: mongodb-10.28.4
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/managed-by: Helm
+     app.kubernetes.io/component: mongodb
+ spec:
+   accessModes:
+     - "ReadWriteOnce"
+   resources:
+     requests:
+       storage: "8Gi"
default, mongodb, Secret (v1) has been added:
+ # Source: mongodb/templates/secrets.yaml
+ apiVersion: v1
+ kind: Secret
+ metadata:
+   labels:
+     app.kubernetes.io/component: mongodb
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/managed-by: Helm
+     app.kubernetes.io/name: mongodb
+     helm.sh/chart: mongodb-10.28.4
+   name: mongodb
+   namespace: default
+ data:
+   mongodb-root-password: '++++++++ # (10 bytes)'
+ type: Opaque

default, mongodb, Service (v1) has been added:
-
+ # Source: mongodb/templates/standalone/svc.yaml
+ apiVersion: v1
+ kind: Service
+ metadata:
+   name: mongodb
+   namespace: default
+   labels:
+     app.kubernetes.io/name: mongodb
+     helm.sh/chart: mongodb-10.28.4
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/managed-by: Helm
+     app.kubernetes.io/component: mongodb
+ spec:
+   type: ClusterIP
+   ports:
+     - name: mongodb
+       port: 27017
+       targetPort: mongodb
+       nodePort: null
+   selector:
+     app.kubernetes.io/name: mongodb
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/component: mongodb
default, mongodb, ServiceAccount (v1) has been added:
-
+ # Source: mongodb/templates/serviceaccount.yaml
+ apiVersion: v1
+ kind: ServiceAccount
+ metadata:
+   name: mongodb
+   namespace: default
+   labels:
+     app.kubernetes.io/name: mongodb
+     helm.sh/chart: mongodb-10.28.4
+     app.kubernetes.io/instance: mongodb
+     app.kubernetes.io/managed-by: Helm
+ secrets:
+   - name: mongodb

Comparing release=swimlane, chart=../swimlane-chart
********************

	Release was not present in Helm.  Diff will show entire contents as new.

********************
default, swimlane, Deployment (apps) has been added:
-
+ # Source: swimlane-practical/templates/deployment.yaml
+ apiVersion: apps/v1
+ kind: Deployment
+ metadata:
+   name: swimlane
+   labels:
+     app.kubernetes.io/component: web
+     app.kubernetes.io/name: swimlane
+     app: swimlane-node
+     chart: swimlane-practical
+     version: 1.0.0
+ spec:
+   selector:
+     matchLabels:
+       app: swimlane-node
+   template:
+     metadata:
+       labels:
+
+         app.kubernetes.io/component: web
+         app.kubernetes.io/name: swimlane
+         app: swimlane-node
+         chart: swimlane-practical
+         version: 1.0.0
+     spec:
+       containers:
+       - name: swimlane
+         image: "alucas052/swimlane-practical:test"
+         imagePullPolicy: IfNotPresent
+         securityContext:
+           runAsUser: 10001
+           allowPrivilegeEscalation: false
+         ports:
+         - containerPort: 3000
+         resources:
+             limits:
+               cpu: 250m
+               memory: 200Mi
+             requests:
+               cpu: 100m
+               memory: 128Mi
+         livenessProbe:
+           failureThreshold: 12
+           tcpSocket:
+             port: 3000
+           initialDelaySeconds: 180
+           periodSeconds: 15
+           successThreshold: 1
+           timeoutSeconds: 3
+         readinessProbe:
+           failureThreshold: 3
+           tcpSocket:
+             port: 3000
+           initialDelaySeconds: 5
+           periodSeconds: 3
+           successThreshold: 1
+           timeoutSeconds: 1
+         env:
+         - name: NODE_ENV
+           value: development
+         - name: MONGODB_URL
+           value: mongodb://root:3bk9mffQk1@mongodb.default.svc.cluster.local:27017/?authSource=admin
+       affinity:
+         podAntiAffinity:
+           preferredDuringSchedulingIgnoredDuringExecution:
+           - weight: 10
+             podAffinityTerm:
+               labelSelector:
+                 matchExpressions:
+                 - key: app
+                   operator: In
+                   values:
+                   - swimlane-node
+               topologyKey: "failure-domain.beta.kubernetes.io/hostname"
default, swimlane-hpa, HorizontalPodAutoscaler (autoscaling) has been added:
-
+ # Source: swimlane-practical/templates/autoscaling.yaml
+ apiVersion: autoscaling/v1
+ kind: HorizontalPodAutoscaler
+ metadata:
+   name: swimlane-hpa
+ spec:
+   maxReplicas: 5
+   minReplicas: 2
+   scaleTargetRef:
+     apiVersion: apps/v1
+     kind: Deployment
+     name: swimlane
+   targetCPUUtilizationPercentage: 50
default, swimlane-node, Service (v1) has been added:
-
+ # Source: swimlane-practical/templates/service.yaml
+ apiVersion: v1
+ kind: Service
+ metadata:
+   labels:
+     app.kubernetes.io/component: web
+     app.kubernetes.io/name: swimlane
+     app: swimlane-node
+     chart: swimlane-practical
+     version: 1.0.0
+     app.kubernetes.io/name: swimlane-node
+   name: swimlane-node
+ spec:
+   ports:
+   - name: http
+     port: 3000
+     protocol: TCP
+     targetPort: 3000
+   selector:
+     app.kubernetes.io/component: swimlane-node
+   type: ClusterIP
default, swimlane-pdb, PodDisruptionBudget (policy) has been added:
-
+ # Source: swimlane-practical/templates/poddisruptionbudget.yaml
+ apiVersion: policy/v1
+ kind: PodDisruptionBudget
+ metadata:
+   name: swimlane-pdb
+   labels:
+     app.kubernetes.io/component: web
+     app.kubernetes.io/name: swimlane
+     app: swimlane-node
+     chart: swimlane-practical
+     version: 1.0.0
+ spec:
+   minAvailable: 1
+   selector:
+     matchLabels:
+       app: swimlane-node

Upgrading release=mongodb, chart=bitnami/mongodb
Upgrading release=swimlane, chart=../swimlane-chart
Release "swimlane" does not exist. Installing it now.
NAME: swimlane
LAST DEPLOYED: Tue Oct 26 16:57:57 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

Listing releases matching ^swimlane$
swimlane	default  	1       	2021-10-26 16:57:57.846356 -0700 PDT	deployed	swimlane-practical-1.0.0	1.0

Release "mongodb" does not exist. Installing it now.
NAME: mongodb
LAST DEPLOYED: Tue Oct 26 16:57:59 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mongodb
CHART VERSION: 10.28.4
APP VERSION: 4.4.10

** Please be patient while the chart is being deployed **

MongoDB&reg; can be accessed on the following DNS name(s) and ports from within your cluster:

    mongodb.default.svc.cluster.local

To get the root password run:

    export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)

To connect to your database, create a MongoDB&reg; client container:

    kubectl run --namespace default mongodb-client --rm --tty -i --restart='Never' --env="MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD" --image docker.io/bitnami/mongodb:4.4.10-debian-10-r11 --command -- bash

Then, run the following command:
    mongo admin --host "mongodb" --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace default svc/mongodb 27017:27017 &
    mongo --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD

Listing releases matching ^mongodb$
mongodb	default  	1       	2021-10-26 16:57:59.312265 -0700 PDT	deployed	mongodb-10.28.4	4.4.10


UPDATED RELEASES:
NAME       CHART               VERSION
swimlane   ../swimlane-chart
mongodb    bitnami/mongodb     10.28.4
```

## Resources created
```
(do-sfo3-k8s-swimlane)❯ k get all -n default
NAME                            READY   STATUS    RESTARTS   AGE
pod/mongodb-98956dfdc-r2kbk     1/1     Running   0          12m
pod/swimlane-77c84487d9-9ksjl   1/1     Running   0          12m
pod/swimlane-77c84487d9-rv5hf   1/1     Running   1          12m

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
service/kubernetes      ClusterIP   10.245.0.1       <none>        443/TCP     5h57m
service/mongodb         ClusterIP   10.245.232.195   <none>        27017/TCP   12m
service/swimlane-node   ClusterIP   10.245.186.46    <none>        3000/TCP    12m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mongodb    1/1     1            1           12m
deployment.apps/swimlane   2/2     2            2           12m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/mongodb-98956dfdc     1         1         1       12m
replicaset.apps/swimlane-77c84487d9   2         2         2       12m

NAME                                               REFERENCE             TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/swimlane-hpa   Deployment/swimlane   <unknown>/50%   2         5         2          12m

~/Documents/swimlane/swimlane-terraform/do_kubernetes_cluster
(do-sfo3-k8s-swimlane)❯ k get pdb
NAME           MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
swimlane-pdb   1               N/A               1                     13m
```
# k8s-self-hosted-recovery
A short tool to recover self-hosted kubeadm provisioned kubernetes clusters

## What is it?

As of [this](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/#caveats) documentation, in version 1.9 you can init a self-hosted k8s cluster, which **cannot** recover from reboots. This little tool solves this issue by switching to static pod plane shortly, to re-enable self-hosting again.

## How to install?

Just by 

```
$ ./install.sh
```

After this, you should be able to reboot your node and expecting it to return and end up in self hosted mode.

You can uninstall this tool simply by:

```
$ ./uninstall.sh
```

## How to watch it happening?

You can watch the recover process by

```
$ journalctl -u k8s-self-hosted-recover
```

and find a log similar to this:

```
Jan 16 14:44:54 wally149 systemd[1]: Started Recovers self-hosted k8s after reboot.
Jan 16 14:44:54 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Restoring old plane...
Jan 16 14:45:00 wally149 k8s-self-hosted-recover[713]: [controlplane] Wrote Static Pod manifest for component kube-apiser
Jan 16 14:45:00 wally149 k8s-self-hosted-recover[713]: [controlplane] Wrote Static Pod manifest for component kube-contro
Jan 16 14:45:00 wally149 k8s-self-hosted-recover[713]: [controlplane] Wrote Static Pod manifest for component kube-schedu
Jan 16 14:45:05 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Waiting while the api server is back..
Jan 16 14:45:21 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Api server online, switch to self-hostin
Jan 16 14:45:21 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Deleting old self-hosting control pane..
Jan 16 14:45:44 wally149 k8s-self-hosted-recover[713]: daemonset "self-hosted-kube-apiserver" deleted
Jan 16 14:46:44 wally149 k8s-self-hosted-recover[713]: daemonset "self-hosted-kube-controller-manager" deleted
Jan 16 14:46:54 wally149 k8s-self-hosted-recover[713]: daemonset "self-hosted-kube-scheduler" deleted
Jan 16 14:46:54 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Re-enable self-hosting...
Jan 16 14:46:55 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 0 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:46:55 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 1 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:47:01 wally149 k8s-self-hosted-recover[713]: [apiclient] The old Pod "kube-apiserver-wally149" is now removed (
Jan 16 14:47:06 wally149 k8s-self-hosted-recover[713]: [apiclient] All control plane components are healthy after 5.00294
Jan 16 14:47:06 wally149 k8s-self-hosted-recover[713]: [self-hosted] self-hosted kube-apiserver ready after 11.636199 sec
Jan 16 14:47:10 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 0 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:47:11 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 1 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:47:14 wally149 k8s-self-hosted-recover[713]: [apiclient] The old Pod "kube-controller-manager-wally149" is now
Jan 16 14:47:14 wally149 k8s-self-hosted-recover[713]: [apiclient] All control plane components are healthy after 0.00099
Jan 16 14:47:14 wally149 k8s-self-hosted-recover[713]: [self-hosted] self-hosted kube-controller-manager ready after 7.58
Jan 16 14:47:14 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 0 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:47:16 wally149 k8s-self-hosted-recover[713]: [apiclient] Found 1 Pods for label selector k8s-app=self-hosted-ku
Jan 16 14:47:20 wally149 k8s-self-hosted-recover[713]: [apiclient] The old Pod "kube-scheduler-wally149" is now removed (
Jan 16 14:47:20 wally149 k8s-self-hosted-recover[713]: [apiclient] All control plane components are healthy after 0.00128
Jan 16 14:47:20 wally149 k8s-self-hosted-recover[713]: [self-hosted] self-hosted kube-scheduler ready after 6.024273 seco
Jan 16 14:47:20 wally149 k8s-self-hosted-recover[713]: [k8s-self-hosted-recover] Re-enabling self-hosting succeeded!
```

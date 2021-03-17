FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.15-openshift-4.8 AS builder
WORKDIR /go/src/github.com/openshift/aws-efs-csi-driver-operator
COPY . .
RUN make

FROM registry.ci.openshift.org/ocp/4.8:base
COPY --from=builder /go/src/github.com/openshift/aws-efs-csi-driver-operator/aws-efs-csi-driver-operator /usr/bin/
ENTRYPOINT ["/usr/bin/aws-efs-csi-driver-operator"]
LABEL io.k8s.display-name="OpenShift AWS EFS CSI Driver Operator" \
	io.k8s.description="The AWS EFS CSI Driver Operator installs and maintains the AWS EFS CSI Driver on a cluster."

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SecurityGroups.R
\name{describe_sgroups}
\alias{describe_sgroups}
\alias{create_sgroup}
\alias{delete_sgroup}
\title{Security Groups}
\usage{
describe_sgroups(sgroup, name, filter, ...)

create_sgroup(name, description, vpc, ...)

delete_sgroup(name, sgroup, ...)
}
\arguments{
\item{sgroup}{A character vector specifying one or more Security Group IDs, or (a list of) objects of class \dQuote{ec2_security_group}.}

\item{name}{A character string (max 255 characters) specifying a security group name.}

\item{filter}{\dots}

\item{...}{Additional arguments passed to [ec2HTTP()].}

\item{description}{A character string specifying a security group description.}

\item{vpc}{A character string specifying a VPC Id (required for a VPC).}
}
\value{
For \code{describe_sgroups} and \code{create_sgroup}, a list of objects of class \dQuote{ec2_security_group}. For \code{delete_sgroup}, a logical.
}
\description{
Describe, create, and delete Security Groups
}
\details{
Security groups provide a layer of security for a Virtual Private Cloud (VPC) for an EC2 instance or set of instances. These can be used in tandem with or in lieu of network Access Control Lists (ACLs) (see \code{\link[=describe_netacls]{describe_netacls()}}). Any given instance can be in multiple security groups, which can be confusing.
}
\examples{
\dontrun{
describe_sgroups()
# create a generic security group
sg1 <- create_sgroup("test_group", "example security group")
delete_sgroup(sg1)

# create a security group within a VPC
## setup the VPC
vpc <- allocate_ip("vpc")
vpc <- describe_ips(vpc)[[1]]
sg2 <- create_sgroup("test_group2", "new security group", vpc = vpc)
}
}
\references{
\url{http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html}
\url{http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html}
\url{http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateSecurityGroup.html}
\url{http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteSecurityGroup.html}
}
\seealso{
\code{\link[=authorize_ingress]{authorize_ingress()}}
}
\keyword{security}

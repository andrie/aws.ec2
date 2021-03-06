#' @rdname gateway_create
#' @title Create/Delete Gateways
#' @description Create and delete Network Gateways for a VPC
#' @template gateway
#' @template dots
#' @references
#' <http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/>
#' <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateInternetGateway.html>
#' <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteInternetGateway.html>
#' @seealso [create_gateway()], [describe_gateways()]
#' @keywords security
#' @export
create_gateway <- function(...) {
    query <- list(Action = "CreateInternetGateway")
    r <- ec2HTTP(query = query, ...)
    return(structure(flatten_list(r$internetGateway), class = "ec2_internet_gateway", requestId = r$requestId))
}

#' @rdname gateway_create
#' @export
delete_gateway <- function(gateway, ...) {
    query <- list(Action = "DeleteInternetGateway",
                  InternetGatewayId = gateway)
    r <- ec2HTTP(query = query, ...)
    if (r$return[[1]] == "true") {
        return(TRUE)
    } else { 
        return(FALSE)
    }
}

#' @rdname gateway_attach
#' @title Attach/detach Gateways
#' @description Attach or Detacth Network Gateways for a VPC
#' @template gateway
#' @template vpc
#' @template dots
#' @references
#' <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AttachInternetGateway.html>
#' <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DetachInternetGateway.html>
#' @seealso [create_gateway()], [describe_gateways()]
#' @keywords security
#' @export
attach_gateway <- function(gateway, vpc, ...) {
    query <- list(Action = "AttachInternetGateway",
                  InternetGatewayId = get_gatewayid(gateway),
                  VpcId = get_vpcid(vpc))
    r <- ec2HTTP(query = query, ...)
    return(r)
}

#' @rdname gateway_attach
#' @export
detach_gateway <- function(gateway, vpc, ...) {
    query <- list(Action = "DetachInternetGateway",
                  InternetGatewayId = get_gatewayid(gateway),
                  VpcId = get_vpcid(vpc))
    r <- ec2HTTP(query = query, ...)
    return(r)
}

#' @title describe_gateways
#' @description Describe Network Gateways
#' @template gateway
#' @template filter
#' @template dots
#' @return A list.
#' @references
#' <http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInternetGateways.html>
#' @seealso [create_gateway()], [attach_gateway()]
#' @keywords security
#' @export
describe_gateways <- function(gateway, filter, ...) {
    query <- list(Action = "DescribeInternetGateways")
    if (!missing(gateway)) {
        if (inherits(gateway, "ec2_internet_gateway")) {
            gateway <- list(get_instanceid(gateway))
        } else if (is.character(gateway)) {
            gateway <- as.list(get_gatewayid(gateway))
        } else {
            gateway <- lapply(gateway, get_gatewayid)
        }
        names(gateway) <- paste0("InternetGatewayId.", 1:length(gateway))
        query <- c(query, gateway)
    }
    if (!missing(filter)) {
        query <- c(query, .makelist(filter, type = "Filter"))
    }
    r <- ec2HTTP(query = query, ...)
    return(structure(r$customerGatewaySet, requestId = r$requestId[[1]]))
}

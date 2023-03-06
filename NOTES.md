# Notes

## Functions

A function accessing resources in OCI requires a dynamic group targeting the function and a policy. Then, your function code use a _resource principal provider_ to get a Resource Provider Session Token (RPST) used to authenticate to other Oracle Cloud resources.

```
function createClientResource() {
  return  new NoSQLClient({
    region: Region.EU_FRANKFURT_1,
    compartment:'ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa',
    auth: {
        iam: {
            useResourcePrincipal: true
        }
    }
  });
}
```

## Fn Project

[Quickstart](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsquickstartlocalhost.htm#functionsquickstartlocalhost)

> Are you using podman?
> Add the following to `~/.fn/config.yaml`
> ```yaml
> container-enginetype: podman
> ```

```
fn start
```

Create Context:
```
fn create context <my-context> --provider oracle
```

Use context:
```
fn use context <my-context>
```

Use an OCI CLI profile (_DEFAULT_):
```
fn update context oracle.profile <profile-name>
```

Select compartment:
```
fn update context oracle.compartment-id <compartment-ocid>
```

Set API endpoint:
```
fn update context api-url https://functions.<region_name>.oci.oraclecloud.com
```

Set registry address:
```
fn update context registry <region-key>.ocir.io/<tenancy-namespace>/<repo-name-prefix>
```

Set registry compartment:
```
fn update context oracle.image-compartment-id <compartment-ocid>
```

## OCI CLI

Get the region code:
```
oci iam region list | jq '.data[] | select(any(contains("FRA")))'
```

Get the tenancy namespace
```
oci os ns get --query "data"
```
# Usage

```sh
oc -n adhoc-admin \
    create cm adhoc-custom \
    --dry-run=client \
    --from-file=scripts/ \
    -o yaml | oc apply -f -
```

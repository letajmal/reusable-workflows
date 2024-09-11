# reusable-workflows

## CI-CD

Example

```yaml
name: <> CI/CD # Optional and recommended to set this same as WORKFLOW ENV

on:
  workflow_dispatch:

jobs:
  cicd:
    uses: ajmaltridz/reusable-workflows/.github/workflows/ci-cd.yaml@main
    with:
      WORKFLOW_ENV: <can be development/production/offline>
      PROJECT: ${{ vars.PROJECT }} # keep it as default
      CI_SERVER: ubuntu-latest # name of the runner which runs all the CI processes
      CD_SERVER: <> # name of the runner which hosts the app
      SKIP_CD: false # whether you want to skip deployment or not, Optional and default is false
    secrets:
      DOCKERHUB_USERNAME: ${{ secrets.DOCKERHUB_USERNAME }} # keep it as default
      DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }} # keep it as default
      TRIDZ_USER: ${{ secrets.TRIDZ_USER }} # keep it as default
      TRIDZ_TOKEN: ${{ secrets.TRIDZ_TOKEN }} # keep it as default
      MARIADB_PASS: ${{ secrets.FSTG_MARIADB_PASS }} # keep it as default
      SITE_DEFAULT_PASS: ${{ secrets.FSTG_SITE_DEFAULT_PASS }} # keep it as default
```
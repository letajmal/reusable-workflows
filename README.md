# reusable-workflows

## CI-CD

fork this repo for use

Example

```yaml
name: <> CI/CD # Optional and recommended to set this same as WORKFLOW ENV

on:
  workflow_dispatch:

jobs:
  cicd:
    uses: <github username>/reusable-workflows/.github/workflows/ci-cd.yaml@main
    with:
      WORKFLOW_ENV: <can be development/production/offline>
      PROJECT: ${{ vars.PROJECT }} # keep it as default
      CI_SERVER: ubuntu-latest # name of the runner which runs all the CI processes
      CD_SERVER: skipcdistrue # name of the runner which hosts the app, keep the default if skip cd is true
      SKIP_CD: true # whether you want to skip deployment or not
    secrets:
      DOCKERHUB_USERNAME: ${{ secrets.DOCKERHUB_USERNAME }} # keep it as default
      DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }} # keep it as default
      DOCKERHUB_REPO: ${{ secrets.DOCKERHUB_REPO }}
      USER: ${{ secrets.USER }} # keep it as default
      USER_TOKEN: ${{ secrets.USER_TOKEN }} # keep it as default
      MARIADB_PASS: ${{ secrets.FSTG_MARIADB_PASS }} # not required
      SITE_DEFAULT_PASS: ${{ secrets.FSTG_SITE_DEFAULT_PASS }} # not required
```
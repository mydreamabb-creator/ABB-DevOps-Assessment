# devops-branching-demo
devops-branching-demo

# Create and switch to new feature branch
git checkout -b feature/add-login-api

# Stage and commit changes
git add .
git commit -m "Implemented login API"

# Push branch to GitHub
git push -u origin feature/add-login-api

# After PR approval and merge
git checkout main
git pull origin main
git branch -d feature/add-login-api

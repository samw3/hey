. ./venv/bin/activate

echo -n "Bump patch version? (y/n) "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "Bumping patch version"
    bump2version patch
    if [ $? -ne 0 ]; then
        echo "❌ Bump failed"
        exit 1
    fi
else
    echo "Not bumping patch version"
fi
rm -rf dist/*
python3 -m build
if [ $? -ne 0 ]; then
    echo "❌ Build failed"
    exit 1
fi

python3 -m twine upload dist/*
if [ $? -ne 0 ]; then
    echo "❌ Upload failed"
    exit 1
fi

echo "✅ Upload successful"

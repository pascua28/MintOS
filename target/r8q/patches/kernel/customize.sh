LOG "- Replacing kernel"

cp "$SRC_DIR/target/r8q/patches/kernel/boot.img" "$WORK_DIR/kernel"
cp "$SRC_DIR/target/r8q/patches/kernel/dtbo.img" "$WORK_DIR/kernel"

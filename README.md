# DPAntiBlockingTextField
#轻量可定制的防键盘遮挡textField
</br>
只要是同过继承UITextField来实现，通过通知监听键盘事件：UIKeyboardWillShowNotification和UIKeyboardWillHideNotification，来判断键盘的高度并通过计算来判断是不是要上移动。
</br>
具体只需要设置dp_offset即可（默认是0）

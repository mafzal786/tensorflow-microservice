import numpy as np


digit=input()
digit2=digit.split(',')
digit3 = np.array(digit2,dtype='float32')


from tensorflow.keras.models import load_model
model = load_model("model.h5")

predict_img = digit3.reshape(1,28,28,1)
#predict_img /=255
# print(w)

prediction = model.predict(predict_img)

print(prediction.argmax())

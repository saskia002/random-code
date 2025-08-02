from deepface import DeepFace


objs = DeepFace.analyze(
  img_path = "img.jpg", 
  actions = ['age', 'gender', 'race', 'emotion'],
)

print(objs)
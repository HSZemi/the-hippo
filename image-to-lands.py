#! /usr/bin/env python3

import sys
import PIL.Image

def create_land(x, y, terrain_type, base_size):
    print(f'''  create_land
  {{
  terrain_type  {terrain_type}
  land_position {x} {y} 
  base_size {base_size}
  number_of_tiles 0
  }}
''')

def main():
    image_file = sys.argv[1]
    terrain_type = sys.argv[2]
    base_size = sys.argv[3]
    
    img = PIL.Image.open(image_file, 'r')
    
    assert img.width == 101
    assert img.height == 101
    
    alpha_channel = img.getchannel('A')
    
    print(f'/* {image_file} */')
    print('if FOLD')
    for x in range(101):
        for y in range(101):
            if alpha_channel.getpixel((x,y)) > 0:
                create_land(x, y, terrain_type, base_size)
    print('endif')
    img.close()

if __name__ == '__main__':
    main()

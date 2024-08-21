
# coding: utf-8

# In[12]:


import os
import folium
import json
from folium.features import CustomIcon
from folium.plugins import FloatImage
from folium.plugins import MousePosition


# In[13]:

flood_NF_0=os.path.join('../saved_images','IS_Baseline.png')
flood_NF=os.path.join('../saved_images','IS_WSF_0.925.png')
flood_NF_1=os.path.join('../saved_images','IS_WSF_1.075.png')
flood_NF_2=os.path.join('../saved_images','IS_WSF_1.225.png')
#flood_PR=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','PR_flood.png')
#flood_CVV80=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','CVV80_flood.png')
#flood_COMB=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','COMB_flood.png')
fld_bar=os.path.join('../saved_images','colorbar.png')

m=folium.Map([36.95,-76.291],zoom_start=14.2,control_scale=True)

map_title = "Scenarios: Wind Speed Factor"
title_html = f'<h2 style="position:absolute;z-index:100000;left:5vw" >{map_title}</h2>'
m.get_root().html.add_child(folium.Element(title_html))

img1=folium.raster_layers.ImageOverlay(
    name='WSF_0.925',
    image=flood_NF,
    bounds=[[36.930,-76.34],[36.970,-76.245]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=True,
)
img1.add_to(m)

img2=folium.raster_layers.ImageOverlay(
    name='WSF_1.075',
    image=flood_NF_1,
    bounds=[[36.930,-76.34],[36.970,-76.245]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)

img2.add_to(m)

img3=folium.raster_layers.ImageOverlay(
    name='WSF_1.225',
    image=flood_NF_2,
    bounds=[[36.930,-76.34],[36.970,-76.245]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)

img3.add_to(m)

# baseline

img0=folium.raster_layers.ImageOverlay(
    name='Baseline, Irene',
    image=flood_NF_0,
    bounds=[[36.930,-76.34],[36.970,-76.245]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)

img0.add_to(m)

# endbaseline

fld_icon=CustomIcon(
     fld_bar,
     icon_size=(2,12),
     icon_anchor=(20,125)
 )
fld_marker=folium.Marker(
     location=[36.5609,-75.811278],
     icon=fld_icon
 )
m.add_child(fld_marker)

FloatImage(fld_bar,bottom=5,left=1).add_to(m)

folium.LayerControl().add_to(m)

kw = {
    'color': 'yellow',
    'line_cap': 'round',
    'fill': True,
   'fill_color': 'none',
    'weight': 2.5,
   'popup': 'Flooding Simulation area',
   'tooltip': '<strong>Click me!</strong>',
}

folium.Rectangle(
    bounds=[[36.930,-76.34],[36.970,-76.245]],
    line_join='round',
    dash_array='5, 5',
    **kw,
).add_to(m)

formatter = "function(num) {return L.Util.formatNum(num, 5) + ' º ';};"

MousePosition(
    position='topright',
    separator=' ,  ',
    empty_string='NaN',
    lng_first=True,
    num_digits=20,
    prefix='Coordinates:',
    lat_formatter=formatter,
    lng_formatter=formatter
).add_to(m)

m.save(os.path.join('../saved_maps', 'IS_WSF.html'))
m



# coding: utf-8

# In[12]:


import os
import folium
import json
from folium.features import CustomIcon
from folium.plugins import FloatImage
from folium.plugins import MousePosition


# In[13]:


flood_NF_1=os.path.join('../saved_images','R1_smdm_flood.png')
flood_NF_2=os.path.join('../saved_images','R2_smdm_flood.png')
flood_NF_3=os.path.join('../saved_images','R4_smdm_flood.png')
flood_NF_4=os.path.join('../saved_images','R6_smdm_flood.png')
flood_NF_5=os.path.join('../saved_images','R3_smdm_flood.png')
flood_NF_6=os.path.join('../saved_images','R5_smdm_flood.png')

fld_bar=os.path.join('../saved_images','colorbar_eta.png')

m=folium.Map([36.96138,-76.27473],zoom_start=14.5,control_scale=True)

map_title = "Flooded Area (FUNWAVE)"
title_html = f'<h2 style="position:absolute;z-index:100000;left:5vw" >{map_title}</h2>'
m.get_root().html.add_child(folium.Element(title_html))

img1=folium.raster_layers.ImageOverlay(
    name='Baseline ERA5',
    image=flood_NF_1,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=True,
)
img1.add_to(m)

img2=folium.raster_layers.ImageOverlay(
    name='Baseline HM',
    image=flood_NF_2,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)
img2.add_to(m)

img3=folium.raster_layers.ImageOverlay(
    name='RMW F1.25',
    image=flood_NF_3,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)
img3.add_to(m)

img4=folium.raster_layers.ImageOverlay(
    name='WSF 1.225',
    image=flood_NF_4,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)
img4.add_to(m)

img5=folium.raster_layers.ImageOverlay(
    name='Bathy Acc 1m',
    image=flood_NF_5,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)
img5.add_to(m)

img6=folium.raster_layers.ImageOverlay(
    name='SLR 1.3m',
    image=flood_NF_6,
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)
img6.add_to(m)

#fld_icon=CustomIcon(
#     fld_bar,
#     icon_size=(2,12),
#     icon_anchor=(20,125)
# )
#fld_marker=folium.Marker(
#     location=[36.5609,-75.811278],
#     icon=fld_icon
# )
#m.add_child(fld_marker)

#FloatImage(fld_bar,bottom=5,left=1).add_to(m)

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
    bounds=[[36.94,-76.3],[36.9750,-76.246]],
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

m.save(os.path.join('../saved_maps', 'FUNWAVE_flood.html'))
m


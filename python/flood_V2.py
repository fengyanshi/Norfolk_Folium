
# coding: utf-8

# In[12]:


import os
import folium
import json
from folium.features import CustomIcon
from folium.plugins import FloatImage
from folium.plugins import MousePosition


# In[13]:


flood_NF=os.path.join('/Users/fengyanshi15/proposal/JACK_2020/TWL/interactive/matlab','hmax_71.png')
hmax_NF=os.path.join('/Users/fengyanshi15/proposal/JACK_2020/TWL/interactive/matlab','hmax_71.png')
#flood_PR=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','PR_flood.png')
#flood_CVV80=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','CVV80_flood.png')
#flood_COMB=os.path.join('/Users/fengyanshi15/work/NTHMP/Flood/VB_2','COMB_flood.png')
#fld_bar=os.path.join('/Users/fengyanshi15/work/NTHMP/colorbar','Colorbar_0_1.png')

m=folium.Map([36.935092999999998,-76.299999999999994],zoom_start=10.2,control_scale=True)
img1=folium.raster_layers.ImageOverlay(
    name='Flood Area',
    image=flood_NF,
#     bounds=[[36.461,-76.211],[36.660722,-75.811278]],
    bounds=[[36.635092999999998,-76.599999999999994],[37.190648000000003,-75.998240999999993]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=True,
)
img1.add_to(m)

img2=folium.raster_layers.ImageOverlay(
    name='Max Elevation',
    image=hmax_NF,
    bounds=[[36.635092999999998,-76.599999999999994],[37.190648000000003,-75.998240999999993]],
    opacity=0.7,
    interactive=True,
    cross_origin=False,
    zindex=1,
    show=False,
)

img2.add_to(m)

#fld_icon=CustomIcon(
#     fld_bar,
#     icon_size=(80,250),
#     icon_anchor=(40,125)
# )
#fld_marker=folium.Marker(
#     location=[36.5609,-75.811278],
#     icon=fld_icon
# )
#m.add_child(fld_marker)

#FloatImage(fld_bar,bottom=0,left=0).add_to(m)

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
    bounds=[[36.635092999999998,-76.599999999999994],[37.190648000000003,-75.998240999999993]],
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

m.save(os.path.join('../maps', 'Flood_NF.html'))
m


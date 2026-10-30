import numpy as np
import plotly.graph_objects as go


def make_surface(n=120, extent=6):
    x = np.linspace(-extent, extent, n)
    y = np.linspace(-extent, extent, n)
    X, Y = np.meshgrid(x, y)
    R = np.hypot(X, Y)
    Z = np.sinc(R / np.pi)  # sin(R) / R

    fig = go.Figure(go.Surface(x=X, y=Y, z=Z, colorscale="Viridis"))
    fig.update_layout(
        height=520,
        margin=dict(l=0, r=0, t=30, b=0),
        scene=dict(xaxis_title="x", yaxis_title="y", zaxis_title="sin(r)/r"),
    )
    return fig

import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np

x = []
y = []
cluster = []

# ---------- READ FILE ----------
with open("results.txt") as f:
    for line in f:
        xi, yi, ci = map(int, line.split())
        x.append(xi)
        y.append(yi)
        cluster.append(ci)

# ---------- PLOT SETUP ----------
fig, ax = plt.subplots()
ax.set_xlim(0, 100)
ax.set_ylim(0, 100)
ax.set_title("K-Means Hardware Visualization")
ax.set_xlabel("X")
ax.set_ylabel("Y")

x_data = []
y_data = []
colors = []

scatter = ax.scatter([], [])
centroid_plot1 = ax.scatter([], [], marker='x', s=150, color='black', label='Centroid 1')
centroid_plot2 = ax.scatter([], [], marker='x', s=150, color='green', label='Centroid 2')

ax.legend()

# ---------- ANIMATION FUNCTION ----------
def update(frame):
    # Add new point
    xi, yi, ci = x[frame], y[frame], cluster[frame]

    x_data.append(xi)
    y_data.append(yi)

    if ci == 0:
        colors.append('red')
    else:
        colors.append('blue')

    scatter.set_offsets(list(zip(x_data, y_data)))
    scatter.set_color(colors)

    # --- Recompute centroids dynamically ---
    cluster0 = [(x_data[i], y_data[i]) for i in range(len(x_data)) if colors[i] == 'red']
    cluster1 = [(x_data[i], y_data[i]) for i in range(len(x_data)) if colors[i] == 'blue']

    if len(cluster0) > 0:
        cx0 = np.mean([p[0] for p in cluster0])
        cy0 = np.mean([p[1] for p in cluster0])
        centroid_plot1.set_offsets([[cx0, cy0]])

    if len(cluster1) > 0:
        cx1 = np.mean([p[0] for p in cluster1])
        cy1 = np.mean([p[1] for p in cluster1])
        centroid_plot2.set_offsets([[cx1, cy1]])

    return scatter, centroid_plot1, centroid_plot2

# ---------- RUN ANIMATION ----------
ani = animation.FuncAnimation(
    fig,
    update,
    frames=len(x),
    interval=400,   # speed (lower = faster)
    repeat=False
)

plt.show()
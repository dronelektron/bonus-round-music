static ArrayList g_indices;
static int g_indicesAmount;
static int g_lastIndex;

void Random_Create(int indicesAmount) {
    delete g_indices;

    g_indices = new ArrayList();
    g_indicesAmount = indicesAmount;

    Random_ResetLastIndex();

    for (int i = 0; i < indicesAmount; i++) {
        g_indices.Push(i);
    }
}

int Random_GetRandomIndex() {
    if (g_lastIndex < 0) {
        Random_ResetLastIndex();
    }

    int index = GetRandomInt(0, g_lastIndex);
    int result = g_indices.Get(index);

    g_indices.SwapAt(index, g_lastIndex);
    g_lastIndex--;

    return result;
}

static void Random_ResetLastIndex() {
    g_lastIndex = g_indicesAmount - 1;
}

// Each collision layer can contains two sets of GameObjects
// that can collide with each other. For example a: bullets b: asteroids
// if you want that asteroids can collide with asteroids,
// you'll want to create a new layer where a: asteroids and b: asteroids.
// The contents of one set can be mixed too, for example for this game
// a: asteroids
// b:
//    - ship
//    - bullets
//    - debris that can cascade (tbd)
//    - asteroids (so that they can collide with themselves)(tbd)
public class CollisionLayer extends Layer {
    ArrayList<GameObject> a;
    ArrayList<GameObject> b;
    final int tileSize = 32;

    final private ArrayList<ArrayList<GameObject>> tilesA;
    final private ArrayList<ArrayList<GameObject>> tilesB;
    
    CollisionLayer(int loadA, int loadB) {
        a = new ArrayList<GameObject>(loadA);
        b = new ArrayList<GameObject>(loadB);

        // The collision system needs to be fast, so we are willing to
        // make space-time trade-offs. That being said, this is Java, and
        // we are only storing pointers anyways, so this should be fine(?)
        // I never benchmarked this, but I'm assuming allocations are expensive
        // so we should try to only do them once!
        tilesA = new ArrayList<ArrayList<GameObject>>(1200);
        tilesB = new ArrayList<ArrayList<GameObject>>(1200);
        int loadPerTileA = loadA / 8;
        int loadPerTileB = loadB / 8;
        for (int i = 0; i < 1200; i++) {
            tilesA.add(new ArrayList<GameObject>(loadPerTileA));
            tilesB.add(new ArrayList<GameObject>(loadPerTileB));
        }
    }

    // For reference: update() in AsteroidField.pde
    private void sortIntoTiles(ArrayList<GameObject> objs, ArrayList<ArrayList<GameObject>> tiles) {
        for (ArrayList<GameObject> l : tiles) {
            l.clear();
        }

        PVector upperLeft = PVector.sub(game.world.camera.position, new PVector(width / 2, height / 2).div(pixelFactor));
        
        int x = int(upperLeft.x - upperLeft.x % tileSize) - tileSize * 2;
        int y = int(upperLeft.y - upperLeft.y % tileSize) - tileSize * 2;
        int maxX = int(upperLeft.x + width / pixelFactor) + tileSize * 2;
        int maxY = int(upperLeft.y + height / pixelFactor) + tileSize * 2;
        int numColumns = (maxX - x) / tileSize;
        int numRows = (maxY - y) / tileSize;

        // We want a frame of padding, so to say
        x += tileSize;
        y += tileSize;
        maxX -= tileSize;
        maxY -= tileSize;

        for (GameObject obj : objs) {
            if (obj.frozen) continue;
            
            int objX = int(obj.position.x);
            int objY = int(obj.position.y);
            
            if (objX < x || objX > maxX || objY < y || objY > maxY) continue;
            
            int px = (objX - x) / tileSize;
            int py = (objY - y) / tileSize;
            
            for (int j = 0; j <= 2; j++) {
                for (int k = 0; k <= 2; k++) {
                    tiles.get((px + j) + numColumns * (py + k)).add(obj);
                }
            }
        }
    }
        
    @Override
    protected void update() {
        sortIntoTiles(a, tilesA);
        sortIntoTiles(b, tilesB);

        for (int i = 0; i < tilesA.size(); i++) {
            ArrayList<GameObject> aTile = tilesA.get(i);
            ArrayList<GameObject> bTile = tilesB.get(i);
            if (aTile.isEmpty() || bTile.isEmpty()) continue;

            for (GameObject aObj : aTile) {
                if (aObj.frozen) continue;
                for (GameObject bObj : bTile) {
                    if (bObj.frozen) continue;

                    float d = PVector.sub(aObj.position, bObj.position).mag();
                    if (d < (aObj.size * aObj.scale + bObj.size * bObj.scale)) {
                        aObj.collision(bObj);
                        bObj.collision(aObj);
                    }
                    
                    if (aObj.frozen) break;
                }
            }
        }
    }
}

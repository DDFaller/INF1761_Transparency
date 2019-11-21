using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QueueManager : MonoBehaviour
{
    private List<BoundComparable> bounds = new List<BoundComparable>();
    private bool setQueue;
    // Start is called before the first frame update

    private class BoundComparable : IComparer<BoundComparable>
    {
        public MeshRenderer render;
        
        public BoundComparable(MeshRenderer mesh)
        {
            render = mesh;
        }

        public int Compare(BoundComparable x, BoundComparable y)
        {
            float xLen = x.render.bounds.size.magnitude;
            float yLen = y.render.bounds.size.magnitude;
            if ( xLen > yLen)
            {
                return 1;
            }
            else if (xLen < yLen)
            {
                return -1;
            }
            return 0;
        }
    }

    void Start()
    {
        setQueue = true;
        MeshRenderer[] children = GetComponentsInChildren<MeshRenderer>();
        int size = children.Length;

        foreach (MeshRenderer render in children)
        {
            bounds.Add( new BoundComparable(render));
        }
        bounds.Sort();
    }

    public void AddRenderer(MeshRenderer render)
    {
        bounds.Add(new BoundComparable(render));
        bounds.Sort();
        setQueue = true;
    }

    void Update()
    {
        if (setQueue) {
            bounds.Sort();
            for (int i = 0; i < bounds.Count;i++)
            {
                BoundComparable temp = bounds[i];
                temp.render.material.renderQueue = 2500 + i;
            }
            setQueue = false;
        }
    }
}

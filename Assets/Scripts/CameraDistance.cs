using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class CameraDistance : MonoBehaviour {

    Transform baseTransform;
    Vector3 objPosition;
    Transform cameraTrans;
    public float distance;
    
    // Start is called before the first frame update
    void Start()
    {
        baseTransform = this.GetComponentInChildren<Transform>();
        if(baseTransform == null)
        {
            baseTransform = this.transform;
        }
        MeshFilter meshFilter = baseTransform.GetComponentInChildren<MeshFilter>();
       
        objPosition = meshFilter.mesh.vertices[meshFilter.mesh.GetBaseVertex(0)];
        cameraTrans = Camera.main.transform;
    }

    // Update is called once per frame
    void Update()
    {

        distance = (objPosition- cameraTrans.transform.position).magnitude ;
    }
}

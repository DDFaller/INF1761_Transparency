﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public int ratio;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            this.transform.Translate(new Vector3(0, 0, 1)/ratio, Space.Self);
        }
        if (Input.GetKey(KeyCode.S))
        {
            this.transform.Translate(new Vector3(0,0,-1)/ratio, Space.Self);
        }
        if (Input.GetKey(KeyCode.A))
        {
            this.transform.Translate(new Vector3(-1,0,0)/ratio, Space.Self);
        }
        if (Input.GetKey(KeyCode.D))
        {
            this.transform.Translate(new Vector3(1,0,0), Space.Self);
        }
    }
}

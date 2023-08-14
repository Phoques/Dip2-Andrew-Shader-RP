using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter))]
public class MeshGen : MonoBehaviour
{
    private Mesh _mesh;
    [SerializeField] private Vector3[] _verticies;
    [SerializeField] private int[] _tris;

    private void Start()
    {
        _mesh = new Mesh();
        GetComponent<MeshFilter>().mesh = _mesh;
        CreateShapeInfo();
        ApplyMeshUpdate();
    }

    private void Update()
    {
        if (Input.GetKey(KeyCode.M))
        {
            ApplyMeshUpdate();
        }
    }

    void CreateShapeInfo()
    {
        _verticies = new Vector3[]
        {
                new Vector3(0, 0, 0),
                new Vector3(0, 0, 1),
                new Vector3(1, 0, 0)
        };

        _tris = new int[]
        {
            0, 1, 2,
        };

    }

    void ApplyMeshUpdate()
    {
        _mesh.Clear();
        _mesh.vertices = _verticies;
        _mesh.triangles = _tris;
        _mesh.RecalculateNormals();
    }

}

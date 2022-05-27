using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BuscaLaExcusa
{
    public class SimpleTerrainGenerator : MonoBehaviour
    {
        [SerializeField] protected MeshFilter _filter;
        [SerializeField] protected Vector2 _offset = Vector2.one;
        [SerializeField] [Range(0f, 10f)] protected float _height = 0.5f;
        [SerializeField] [Range(0f, 10f)] protected float _scale = 0.5f;


        private void Awake()
        {
            GenerateTerrain();
        }

        private void GenerateTerrain()
        {
            Mesh mesh = _filter.mesh;
            Vector3[] vertices = mesh.vertices;
            for (int i = 0; i < vertices.Length; ++i)
            {
                Vector3 vertex = vertices[i];
                vertex.y = GetHeight(vertex.x, vertex.z);
                vertices[i] = vertex;
            }
            mesh.vertices = vertices;
            mesh.RecalculateNormals();
        }

        private float GetHeight(float x, float z)
        {
            x += _offset.x;
            z += _offset.y;
            return Mathf.PerlinNoise(x / _filter.mesh.bounds.size.x * _scale, z / _filter.mesh.bounds.size.z * _scale) * _height;
        }

        private void OnDrawGizmos()
        {
            if (!Application.isPlaying)
            {
                return;
            }

            GenerateTerrain();
        }

    }
}
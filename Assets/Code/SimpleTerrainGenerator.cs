using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BuscaLaExcusa
{
    public class SimpleTerrainGenerator : MonoBehaviour
    {

        [SerializeField] protected MeshFilter _filter;
        [SerializeField] protected Vector2 _offset = Vector2.one;
        [SerializeField] [Range(0f, 10f)] protected float _mountainHeight = 0.5f;
        [SerializeField] [Range(0f, 10f)] protected float _mountainSpread = 0.2f;
        [SerializeField] [Range(0f, 10f)] protected float _roughnessDepth = 0.5f;
        [SerializeField] [Range(0f, 10f)] protected float _roughnessSpread = 0.2f;


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

                float x = _offset.x + vertex.x;
                float z = _offset.y + vertex.z;

                float mountainValue = _mountainHeight * Mathf.PerlinNoise(_mountainSpread * x, _mountainSpread * z);
                float roughness = _roughnessDepth * Mathf.PerlinNoise(_roughnessSpread * x, _roughnessSpread * z);

                vertex.y = mountainValue;
                vertex.y += Mathf.Abs(roughness);

                vertices[i] = vertex;
            }
            mesh.vertices = vertices;
            mesh.RecalculateNormals();
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
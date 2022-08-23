function sigma = compute_stress(Q, E, L, cos, sin, node1, node2)
    c = cos; s = sin;
    sigma = E/L*[-c -s c s]*[Q(2*node1-1); Q(2*node1); Q(2*node2-1); Q(2*node2)];
end
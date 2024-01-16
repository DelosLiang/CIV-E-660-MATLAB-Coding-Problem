## Assignment 1 MATLAB code

### Pattern 3

#### main


* Parameters configuration


* Define the concentrated force boundary [node number, force, dimension of DOF](vertical direction）


* Generate the node number corresponding to each element


* The concentrated force boundary is introduced to calculate F


* Calculate element stiffness matrix k


* Assemble global stiffness matrix K(ID array approach)


* Diagonal elements change 1 to introduce displacement boundary


* Solve for KU=P, to generate the nodal displacements in the global coordinate system


* Determine nodal displacements of each element in the local coordinate system


* Determine the element end forces in the local and global coordinate system


* Determine the reaction forces of support 1 and 3


* Determine axial forces of each element


* Plot the axial force diagram


* Plot the deformed truss structure with the undeformed structure as background

#### Function


* mesh_def
    
    This function defines the node number corresponding to each element.
    
    
* cal_k_local

    This function generates stiffness matrix for each element in local coordinate system.
    
    
* cal_k

    This function generates stiffness matrix for each element in global coordinate system.
    
    
* trans

    This function defines transformation matrix for an element-end displacement vector from a global coordinate system to local coordinate system.
    
    
* disp_cal
 
     This function determines nodal displacements of each element in the local coordinate system.
     
     
* f_local_cal
 
     This function determines element end forces in the local coordinate system.
     
     
* f_global_cal

    This function determines element end forces in the global coordinate system
    
    
* axial_f_cal
 
     This function generates axial forces of each element.
     
     
* mesh_plot

    This function stores coordinates of each node.

### Pattern n

#### main


* Parameters configuration


* Define the concentrated force boundary [node number, force, dimension of DOF](vertical direction）


* Generate the node number corresponding to each element


* The concentrated force boundary is introduced to calculate F


* Calculate element stiffness matrix k


* Assemble global stiffness matrix K


* Diagonal elements change 1 to introduce displacement boundary


* Solve for KU=P, to generate U


* Print the the deformation at the bottom node located at the middle span of the truss structure

#### Function


* mesh_def

    This function defines the node number corresponding to each element.
    
    
* force_boundary

    This function returns force array.
    
    
* cal_k

    This function generates stiffness matrix for each element in global coordinate system.

#### Visualization


* Load_Displacement_curve

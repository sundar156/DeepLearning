       �K"	  �t|O�Abrain.Event:2&��/      �J�	�B�t|O�A"�^
j
x-inputPlaceholder*
dtype0*'
_output_shapes
:���������*
shape:���������
j
y-inputPlaceholder*
shape:���������*
dtype0*'
_output_shapes
:���������
X
l2_normalize/SquareSquarex-input*
T0*'
_output_shapes
:���������
d
"l2_normalize/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 
�
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*
T0*'
_output_shapes
:���������*
	keep_dims(*

Tidx0
[
l2_normalize/Maximum/yConst*
dtype0*
_output_shapes
: *
valueB
 *̼�+
{
l2_normalize/MaximumMaximuml2_normalize/Suml2_normalize/Maximum/y*
T0*'
_output_shapes
:���������
c
l2_normalize/RsqrtRsqrtl2_normalize/Maximum*'
_output_shapes
:���������*
T0
b
l2_normalizeMulx-inputl2_normalize/Rsqrt*'
_output_shapes
:���������*
T0
\
WeightsConst*
valueB*    *
dtype0*
_output_shapes

:
|
Variable
VariableV2*
dtype0*
_output_shapes

:*
	container *
shape
:*
shared_name 
�
Variable/AssignAssignVariableWeights*
use_locking(*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:
i
Variable/readIdentityVariable*
T0*
_class
loc:@Variable*
_output_shapes

:
Q
BiasConst*
valueB*    *
dtype0*
_output_shapes
:
v

Variable_1
VariableV2*
dtype0*
_output_shapes
:*
	container *
shape:*
shared_name 
�
Variable_1/AssignAssign
Variable_1Bias*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*
_class
loc:@Variable_1
k
Variable_1/readIdentity
Variable_1*
T0*
_class
loc:@Variable_1*
_output_shapes
:
A
readIdentity
Variable_1*
_output_shapes
:*
T0
�
MatMulMatMull2_normalizeVariable/read*
transpose_b( *
T0*'
_output_shapes
:���������*
transpose_a( 
X
outputAddMatMulVariable_1/read*'
_output_shapes
:���������*
T0
M
subSuboutputy-input*'
_output_shapes
:���������*
T0
G
SquareSquaresub*
T0*'
_output_shapes
:���������
V
ConstConst*
valueB"       *
dtype0*
_output_shapes
:
Y
LossMeanSquareConst*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
X
gradients/grad_ys_0Const*
valueB
 *  �?*
dtype0*
_output_shapes
: 
o
gradients/FillFillgradients/Shapegradients/grad_ys_0*
T0*

index_type0*
_output_shapes
: 
r
!gradients/Loss_grad/Reshape/shapeConst*
dtype0*
_output_shapes
:*
valueB"      
�
gradients/Loss_grad/ReshapeReshapegradients/Fill!gradients/Loss_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
_
gradients/Loss_grad/ShapeShapeSquare*
T0*
out_type0*
_output_shapes
:
�
gradients/Loss_grad/TileTilegradients/Loss_grad/Reshapegradients/Loss_grad/Shape*'
_output_shapes
:���������*

Tmultiples0*
T0
a
gradients/Loss_grad/Shape_1ShapeSquare*
T0*
out_type0*
_output_shapes
:
^
gradients/Loss_grad/Shape_2Const*
valueB *
dtype0*
_output_shapes
: 
c
gradients/Loss_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
�
gradients/Loss_grad/ProdProdgradients/Loss_grad/Shape_1gradients/Loss_grad/Const*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
e
gradients/Loss_grad/Const_1Const*
valueB: *
dtype0*
_output_shapes
:
�
gradients/Loss_grad/Prod_1Prodgradients/Loss_grad/Shape_2gradients/Loss_grad/Const_1*
T0*
_output_shapes
: *
	keep_dims( *

Tidx0
_
gradients/Loss_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
�
gradients/Loss_grad/MaximumMaximumgradients/Loss_grad/Prod_1gradients/Loss_grad/Maximum/y*
T0*
_output_shapes
: 
�
gradients/Loss_grad/floordivFloorDivgradients/Loss_grad/Prodgradients/Loss_grad/Maximum*
T0*
_output_shapes
: 
~
gradients/Loss_grad/CastCastgradients/Loss_grad/floordiv*

SrcT0*
Truncate( *
_output_shapes
: *

DstT0
�
gradients/Loss_grad/truedivRealDivgradients/Loss_grad/Tilegradients/Loss_grad/Cast*
T0*'
_output_shapes
:���������
~
gradients/Square_grad/ConstConst^gradients/Loss_grad/truediv*
dtype0*
_output_shapes
: *
valueB
 *   @
t
gradients/Square_grad/MulMulsubgradients/Square_grad/Const*
T0*'
_output_shapes
:���������
�
gradients/Square_grad/Mul_1Mulgradients/Loss_grad/truedivgradients/Square_grad/Mul*
T0*'
_output_shapes
:���������
^
gradients/sub_grad/ShapeShapeoutput*
T0*
out_type0*
_output_shapes
:
a
gradients/sub_grad/Shape_1Shapey-input*
_output_shapes
:*
T0*
out_type0
�
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/sub_grad/SumSumgradients/Square_grad/Mul_1(gradients/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:���������
�
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*
	keep_dims( *

Tidx0
Z
gradients/sub_grad/NegNeggradients/sub_grad/Sum_1*
T0*
_output_shapes
:
�
gradients/sub_grad/Reshape_1Reshapegradients/sub_grad/Neggradients/sub_grad/Shape_1*'
_output_shapes
:���������*
T0*
Tshape0
g
#gradients/sub_grad/tuple/group_depsNoOp^gradients/sub_grad/Reshape^gradients/sub_grad/Reshape_1
�
+gradients/sub_grad/tuple/control_dependencyIdentitygradients/sub_grad/Reshape$^gradients/sub_grad/tuple/group_deps*'
_output_shapes
:���������*
T0*-
_class#
!loc:@gradients/sub_grad/Reshape
�
-gradients/sub_grad/tuple/control_dependency_1Identitygradients/sub_grad/Reshape_1$^gradients/sub_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_grad/Reshape_1*'
_output_shapes
:���������
a
gradients/output_grad/ShapeShapeMatMul*
T0*
out_type0*
_output_shapes
:
g
gradients/output_grad/Shape_1Const*
dtype0*
_output_shapes
:*
valueB:
�
+gradients/output_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/output_grad/Shapegradients/output_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
�
gradients/output_grad/ReshapeReshapegradients/output_grad/Sumgradients/output_grad/Shape*'
_output_shapes
:���������*
T0*
Tshape0
�
gradients/output_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency-gradients/output_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/output_grad/Reshape_1Reshapegradients/output_grad/Sum_1gradients/output_grad/Shape_1*
_output_shapes
:*
T0*
Tshape0
p
&gradients/output_grad/tuple/group_depsNoOp^gradients/output_grad/Reshape ^gradients/output_grad/Reshape_1
�
.gradients/output_grad/tuple/control_dependencyIdentitygradients/output_grad/Reshape'^gradients/output_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients/output_grad/Reshape*'
_output_shapes
:���������
�
0gradients/output_grad/tuple/control_dependency_1Identitygradients/output_grad/Reshape_1'^gradients/output_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients/output_grad/Reshape_1*
_output_shapes
:
�
gradients/MatMul_grad/MatMulMatMul.gradients/output_grad/tuple/control_dependencyVariable/read*
transpose_b(*
T0*'
_output_shapes
:���������*
transpose_a( 
�
gradients/MatMul_grad/MatMul_1MatMull2_normalize.gradients/output_grad/tuple/control_dependency*
T0*
_output_shapes

:*
transpose_a(*
transpose_b( 
n
&gradients/MatMul_grad/tuple/group_depsNoOp^gradients/MatMul_grad/MatMul^gradients/MatMul_grad/MatMul_1
�
.gradients/MatMul_grad/tuple/control_dependencyIdentitygradients/MatMul_grad/MatMul'^gradients/MatMul_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/MatMul_grad/MatMul*'
_output_shapes
:���������
�
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1*
_output_shapes

:
b
GradientDescent/learning_rateConst*
valueB
 *���=*
dtype0*
_output_shapes
: 
�
4GradientDescent/update_Variable/ApplyGradientDescentApplyGradientDescentVariableGradientDescent/learning_rate0gradients/MatMul_grad/tuple/control_dependency_1*
use_locking( *
T0*
_class
loc:@Variable*
_output_shapes

:
�
6GradientDescent/update_Variable_1/ApplyGradientDescentApplyGradientDescent
Variable_1GradientDescent/learning_rate0gradients/output_grad/tuple/control_dependency_1*
use_locking( *
T0*
_class
loc:@Variable_1*
_output_shapes
:
�
GradientDescentNoOp5^GradientDescent/update_Variable/ApplyGradientDescent7^GradientDescent/update_Variable_1/ApplyGradientDescent
2
initNoOp^Variable/Assign^Variable_1/Assign
Z
train_loss/tagsConst*
valueB B
train_loss*
dtype0*
_output_shapes
: 
S

train_lossScalarSummarytrain_loss/tagsLoss*
T0*
_output_shapes
: 
4
init_1NoOp^Variable/Assign^Variable_1/Assign
Y
save/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
n
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
_output_shapes
: *
shape: 
e

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
_output_shapes
: *
shape: 
u
save/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
g
save/SaveV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueBB B 
�
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const*
_output_shapes
: 
�
save/RestoreV2/tensor_namesConst"/device:CPU:0*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
y
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B *
dtype0*
_output_shapes
:
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::
�
save/AssignAssignVariablesave/RestoreV2*
use_locking(*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:
�
save/Assign_1Assign
Variable_1save/RestoreV2:1*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:*
use_locking(
6
save/restore_allNoOp^save/Assign^save/Assign_1"h�:      Uq�e	w��t|O�AJ�u
��
:
Add
x"T
y"T
z"T"
Ttype:
2	
�
ApplyGradientDescent
var"T�

alpha"T

delta"T
out"T�" 
Ttype:
2	"
use_lockingbool( 
x
Assign
ref"T�

value"T

output_ref"T�"	
Ttype"
validate_shapebool("
use_lockingbool(�
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
8
Const
output"dtype"
valuetensor"
dtypetype
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
?
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
;
Maximum
x"T
y"T
z"T"
Ttype:

2	�
�
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
=
Mul
x"T
y"T
z"T"
Ttype:
2	�
.
Neg
x"T
y"T"
Ttype:

2	

NoOp
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
�
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
>
RealDiv
x"T
y"T
z"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
.
Rsqrt
x"T
y"T"
Ttype:

2
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
P
ScalarSummary
tags
values"T
summary"
Ttype:
2	
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
1
Square
x"T
y"T"
Ttype:

2	
:
Sub
x"T
y"T
z"T"
Ttype:
2	
�
Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	
s

VariableV2
ref"dtype�"
shapeshape"
dtypetype"
	containerstring "
shared_namestring �*1.13.12b'v1.13.0-rc2-5-g6612da8951'�^
j
x-inputPlaceholder*
dtype0*'
_output_shapes
:���������*
shape:���������
j
y-inputPlaceholder*
dtype0*'
_output_shapes
:���������*
shape:���������
X
l2_normalize/SquareSquarex-input*
T0*'
_output_shapes
:���������
d
"l2_normalize/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 
�
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*
T0*'
_output_shapes
:���������*

Tidx0*
	keep_dims(
[
l2_normalize/Maximum/yConst*
valueB
 *̼�+*
dtype0*
_output_shapes
: 
{
l2_normalize/MaximumMaximuml2_normalize/Suml2_normalize/Maximum/y*
T0*'
_output_shapes
:���������
c
l2_normalize/RsqrtRsqrtl2_normalize/Maximum*
T0*'
_output_shapes
:���������
b
l2_normalizeMulx-inputl2_normalize/Rsqrt*
T0*'
_output_shapes
:���������
\
WeightsConst*
valueB*    *
dtype0*
_output_shapes

:
|
Variable
VariableV2*
dtype0*
	container *
_output_shapes

:*
shape
:*
shared_name 
�
Variable/AssignAssignVariableWeights*
use_locking(*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:
i
Variable/readIdentityVariable*
T0*
_class
loc:@Variable*
_output_shapes

:
Q
BiasConst*
valueB*    *
dtype0*
_output_shapes
:
v

Variable_1
VariableV2*
shape:*
shared_name *
dtype0*
	container *
_output_shapes
:
�
Variable_1/AssignAssign
Variable_1Bias*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:*
use_locking(
k
Variable_1/readIdentity
Variable_1*
T0*
_class
loc:@Variable_1*
_output_shapes
:
A
readIdentity
Variable_1*
T0*
_output_shapes
:
�
MatMulMatMull2_normalizeVariable/read*
T0*
transpose_a( *'
_output_shapes
:���������*
transpose_b( 
X
outputAddMatMulVariable_1/read*'
_output_shapes
:���������*
T0
M
subSuboutputy-input*
T0*'
_output_shapes
:���������
G
SquareSquaresub*
T0*'
_output_shapes
:���������
V
ConstConst*
valueB"       *
dtype0*
_output_shapes
:
Y
LossMeanSquareConst*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
X
gradients/grad_ys_0Const*
valueB
 *  �?*
dtype0*
_output_shapes
: 
o
gradients/FillFillgradients/Shapegradients/grad_ys_0*
T0*

index_type0*
_output_shapes
: 
r
!gradients/Loss_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
�
gradients/Loss_grad/ReshapeReshapegradients/Fill!gradients/Loss_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
_
gradients/Loss_grad/ShapeShapeSquare*
T0*
out_type0*
_output_shapes
:
�
gradients/Loss_grad/TileTilegradients/Loss_grad/Reshapegradients/Loss_grad/Shape*
T0*'
_output_shapes
:���������*

Tmultiples0
a
gradients/Loss_grad/Shape_1ShapeSquare*
T0*
out_type0*
_output_shapes
:
^
gradients/Loss_grad/Shape_2Const*
valueB *
dtype0*
_output_shapes
: 
c
gradients/Loss_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
�
gradients/Loss_grad/ProdProdgradients/Loss_grad/Shape_1gradients/Loss_grad/Const*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
e
gradients/Loss_grad/Const_1Const*
dtype0*
_output_shapes
:*
valueB: 
�
gradients/Loss_grad/Prod_1Prodgradients/Loss_grad/Shape_2gradients/Loss_grad/Const_1*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
_
gradients/Loss_grad/Maximum/yConst*
dtype0*
_output_shapes
: *
value	B :
�
gradients/Loss_grad/MaximumMaximumgradients/Loss_grad/Prod_1gradients/Loss_grad/Maximum/y*
T0*
_output_shapes
: 
�
gradients/Loss_grad/floordivFloorDivgradients/Loss_grad/Prodgradients/Loss_grad/Maximum*
T0*
_output_shapes
: 
~
gradients/Loss_grad/CastCastgradients/Loss_grad/floordiv*

SrcT0*
Truncate( *

DstT0*
_output_shapes
: 
�
gradients/Loss_grad/truedivRealDivgradients/Loss_grad/Tilegradients/Loss_grad/Cast*'
_output_shapes
:���������*
T0
~
gradients/Square_grad/ConstConst^gradients/Loss_grad/truediv*
valueB
 *   @*
dtype0*
_output_shapes
: 
t
gradients/Square_grad/MulMulsubgradients/Square_grad/Const*
T0*'
_output_shapes
:���������
�
gradients/Square_grad/Mul_1Mulgradients/Loss_grad/truedivgradients/Square_grad/Mul*
T0*'
_output_shapes
:���������
^
gradients/sub_grad/ShapeShapeoutput*
T0*
out_type0*
_output_shapes
:
a
gradients/sub_grad/Shape_1Shapey-input*
T0*
out_type0*
_output_shapes
:
�
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/sub_grad/SumSumgradients/Square_grad/Mul_1(gradients/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
�
gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*'
_output_shapes
:���������*
T0*
Tshape0
�
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Z
gradients/sub_grad/NegNeggradients/sub_grad/Sum_1*
T0*
_output_shapes
:
�
gradients/sub_grad/Reshape_1Reshapegradients/sub_grad/Neggradients/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:���������
g
#gradients/sub_grad/tuple/group_depsNoOp^gradients/sub_grad/Reshape^gradients/sub_grad/Reshape_1
�
+gradients/sub_grad/tuple/control_dependencyIdentitygradients/sub_grad/Reshape$^gradients/sub_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/sub_grad/Reshape*'
_output_shapes
:���������
�
-gradients/sub_grad/tuple/control_dependency_1Identitygradients/sub_grad/Reshape_1$^gradients/sub_grad/tuple/group_deps*'
_output_shapes
:���������*
T0*/
_class%
#!loc:@gradients/sub_grad/Reshape_1
a
gradients/output_grad/ShapeShapeMatMul*
T0*
out_type0*
_output_shapes
:
g
gradients/output_grad/Shape_1Const*
dtype0*
_output_shapes
:*
valueB:
�
+gradients/output_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/output_grad/Shapegradients/output_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
�
gradients/output_grad/ReshapeReshapegradients/output_grad/Sumgradients/output_grad/Shape*
T0*
Tshape0*'
_output_shapes
:���������
�
gradients/output_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency-gradients/output_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
�
gradients/output_grad/Reshape_1Reshapegradients/output_grad/Sum_1gradients/output_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:
p
&gradients/output_grad/tuple/group_depsNoOp^gradients/output_grad/Reshape ^gradients/output_grad/Reshape_1
�
.gradients/output_grad/tuple/control_dependencyIdentitygradients/output_grad/Reshape'^gradients/output_grad/tuple/group_deps*'
_output_shapes
:���������*
T0*0
_class&
$"loc:@gradients/output_grad/Reshape
�
0gradients/output_grad/tuple/control_dependency_1Identitygradients/output_grad/Reshape_1'^gradients/output_grad/tuple/group_deps*
T0*2
_class(
&$loc:@gradients/output_grad/Reshape_1*
_output_shapes
:
�
gradients/MatMul_grad/MatMulMatMul.gradients/output_grad/tuple/control_dependencyVariable/read*
T0*
transpose_a( *'
_output_shapes
:���������*
transpose_b(
�
gradients/MatMul_grad/MatMul_1MatMull2_normalize.gradients/output_grad/tuple/control_dependency*
transpose_a(*
_output_shapes

:*
transpose_b( *
T0
n
&gradients/MatMul_grad/tuple/group_depsNoOp^gradients/MatMul_grad/MatMul^gradients/MatMul_grad/MatMul_1
�
.gradients/MatMul_grad/tuple/control_dependencyIdentitygradients/MatMul_grad/MatMul'^gradients/MatMul_grad/tuple/group_deps*'
_output_shapes
:���������*
T0*/
_class%
#!loc:@gradients/MatMul_grad/MatMul
�
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1*
_output_shapes

:
b
GradientDescent/learning_rateConst*
valueB
 *���=*
dtype0*
_output_shapes
: 
�
4GradientDescent/update_Variable/ApplyGradientDescentApplyGradientDescentVariableGradientDescent/learning_rate0gradients/MatMul_grad/tuple/control_dependency_1*
T0*
_class
loc:@Variable*
_output_shapes

:*
use_locking( 
�
6GradientDescent/update_Variable_1/ApplyGradientDescentApplyGradientDescent
Variable_1GradientDescent/learning_rate0gradients/output_grad/tuple/control_dependency_1*
use_locking( *
T0*
_class
loc:@Variable_1*
_output_shapes
:
�
GradientDescentNoOp5^GradientDescent/update_Variable/ApplyGradientDescent7^GradientDescent/update_Variable_1/ApplyGradientDescent
2
initNoOp^Variable/Assign^Variable_1/Assign
Z
train_loss/tagsConst*
valueB B
train_loss*
dtype0*
_output_shapes
: 
S

train_lossScalarSummarytrain_loss/tagsLoss*
T0*
_output_shapes
: 
4
init_1NoOp^Variable/Assign^Variable_1/Assign
Y
save/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
n
save/filenamePlaceholderWithDefaultsave/filename/input*
shape: *
dtype0*
_output_shapes
: 
e

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
_output_shapes
: *
shape: 
u
save/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
g
save/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
�
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
_output_shapes
: *
T0*
_class
loc:@save/Const
�
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*
_output_shapes
:*)
value BBVariableB
Variable_1
y
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B *
dtype0*
_output_shapes
:
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::
�
save/AssignAssignVariablesave/RestoreV2*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class
loc:@Variable
�
save/Assign_1Assign
Variable_1save/RestoreV2:1*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:*
use_locking(
6
save/restore_allNoOp^save/Assign^save/Assign_1""
	summaries

train_loss:0"�
trainable_variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08"
train_op

GradientDescent"�
	variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08��2       ��2	���t|O�A*


train_lossg	D���        )��P	 �t|O�A*


train_loss��C�         )��P	��t|O�A*


train_loss5}CTj+        )��P	V��t|O�A*


train_lossR��B���{        )��P	���t|O�A*


train_lossḴB��X�        )��P	q�t|O�A*


train_lossa
�B25�\        )��P	��t|O�A*


train_loss�d�B��         )��P	��t|O�A*


train_loss�ʞBY4��        )��P	�#�t|O�A*


train_lossY�B����        )��P	�-�t|O�A	*


train_loss�Z�B�B�V        )��P	H5�t|O�A
*


train_loss|��B�(�@        )��P	�;�t|O�A*


train_loss�ΚBƞ�2        )��P	�A�t|O�A*


train_lossN�B:�<�        )��P	9H�t|O�A*


train_loss�r�B�U'�        )��P	�N�t|O�A*


train_loss͘BB*X�        )��P	zU�t|O�A*


train_loss�+�BA�2�        )��P	�[�t|O�A*


train_loss��BM�;b        )��P	|b�t|O�A*


train_loss?��B�9�/        )��P	�j�t|O�A*


train_lossLa�Bn��        )��P	�r�t|O�A*


train_loss"ЕB�kU        )��P	x{�t|O�A*


train_loss�B�B�Ib�        )��P	M��t|O�A*


train_loss���B���        )��P	ƈ�t|O�A*


train_lossW2�B��P�        )��P	&��t|O�A*


train_lossT��B}��        )��P	ݕ�t|O�A*


train_loss�/�By��        )��P	��t|O�A*


train_loss'��B@�Z        )��P	���t|O�A*


train_loss�9�B^V��        )��P	?��t|O�A*


train_loss�ÑB�|�#        )��P	l��t|O�A*


train_lossGP�B�i�f        )��P	ж�t|O�A*


train_loss�ߐB#"        )��P	8��t|O�A*


train_lossYr�B�2NZ        )��P	�Ùt|O�A*


train_loss��B��        )��P	�ət|O�A *


train_lossq��Bp��A        )��P	љt|O�A!*


train_loss�9�B�`        )��P	�יt|O�A"*


train_loss׎B<�h        )��P	Dޙt|O�A#*


train_loss�v�B��[        )��P	��t|O�A$*


train_loss��B��]        )��P	p�t|O�A%*


train_lossμ�B����        )��P	��t|O�A&*


train_lossjc�Bp43�        )��P	��t|O�A'*


train_lossB�BZkU�        )��P	u�t|O�A(*


train_lossH��B���        )��P	��t|O�A)*


train_losskd�B�A,        )��P	�t|O�A**


train_loss��B(��        )��P	��t|O�A+*


train_loss�ċB%�bx        )��P	B"�t|O�A,*


train_lossx�B�t�        )��P	g(�t|O�A-*


train_loss-�B�]n        )��P	/�t|O�A.*


train_loss�B�
*        )��P	7�t|O�A/*


train_loss֜�Bu[�        )��P	_A�t|O�A0*


train_loss^W�B�Ǝ�        )��P	�H�t|O�A1*


train_loss��B�R��        )��P	�Q�t|O�A2*


train_loss�щB&m5�        )��P	�Y�t|O�A3*


train_loss��B\Én        )��P	0g�t|O�A4*


train_lossBR�B��ް        )��P	�p�t|O�A5*


train_loss��B��W        )��P	���t|O�A6*


train_loss(وBR�        )��P	 ��t|O�A7*


train_lossמ�B3�        )��P	ʥ�t|O�A8*


train_loss�e�BpV�        )��P	ͱ�t|O�A9*


train_losst.�Bz7$�        )��P	�t|O�A:*


train_lossR��B�]�P        )��P	Кt|O�A;*


train_loss�ÇB�rv9        )��P	�ݚt|O�A<*


train_loss���BS���        )��P	5�t|O�A=*


train_loss�]�B����        )��P	���t|O�A>*


train_loss�,�BQ$�[        )��P	[�t|O�A?*


train_loss���Bꏮ�        )��P	��t|O�A@*


train_loss#ΆB�a(�        )��P	��t|O�AA*


train_loss���B�P�        )��P	�)�t|O�AB*


train_loss t�B�C�\        )��P	�<�t|O�AC*


train_loss�H�B���        )��P	�H�t|O�AD*


train_lossj�B=I=�        )��P	�S�t|O�AE*


train_loss��B�[iZ        )��P	a�t|O�AF*


train_loss�̅B��         )��P	~o�t|O�AG*


train_lossm��B�4P        )��P	O��t|O�AH*


train_loss�B���        )��P	/��t|O�AI*


train_loss�Y�Bɴ�:        )��P	묛t|O�AJ*


train_loss�4�B"���        )��P	UÛt|O�AK*


train_loss0�Bl��        )��P	�Λt|O�AL*


train_lossO�BI��        )��P	ٛt|O�AM*


train_lossĀB���        )��P	��t|O�AN*


train_loss��B�,z�        )��P	��t|O�AO*


train_loss���B�K�+        )��P	���t|O�AP*


train_loss�j�Bo�R        )��P	?��t|O�AQ*


train_loss�K�BA!�        )��P	��t|O�AR*


train_loss�-�B���        )��P	C�t|O�AS*


train_loss"�Bd���        )��P	)(�t|O�AT*


train_lossM�BB]�        )��P	gB�t|O�AU*


train_loss#׃B	�;        )��P	YT�t|O�AV*


train_loss���Bb�I�        )��P	�b�t|O�AW*


train_loss���B�yu�        )��P	?q�t|O�AX*


train_loss���B�Q^�        )��P	�~�t|O�AY*


train_loss�l�Bk��G        )��P	���t|O�AZ*


train_loss�S�BN���        )��P	���t|O�A[*


train_lossN;�B�e�,        )��P	���t|O�A\*


train_lossb#�B�QRt        )��P	Fќt|O�A]*


train_loss �B���"        )��P	��t|O�A^*


train_loss%��B/�w�        )��P	��t|O�A_*


train_loss�ނBJ�T        )��P	� �t|O�A`*


train_loss�ȂB���        )��P	��t|O�Aa*


train_loss���B����        )��P	D�t|O�Ab*


train_lossÞ�B�.�        )��P	�(�t|O�Ac*


train_loss]��B�5˅        )��P	78�t|O�Ad*


train_losskv�B��        )��P	�h�t|O�Ae*


train_loss�b�B�~�        )��P	�w�t|O�Af*


train_loss�O�BMi�        )��P	���t|O�Ag*


train_loss0=�BӮ        )��P	���t|O�Ah*


train_loss�*�B ��        )��P	���t|O�Ai*


train_loss�B��E        )��P	vÞt|O�Aj*


train_loss��Bu��        )��P	�Ϟt|O�Ak*


train_loss���B�%        )��P	�ڞt|O�Al*


train_loss��B����        )��P	G�t|O�Am*


train_lossyՁB�_�        )��P	���t|O�An*


train_lossxŁB���T        )��P	2�t|O�Ao*


train_lossε�BWB'        )��P	b�t|O�Ap*


train_lossy��B���y        )��P	��t|O�Aq*


train_lossv��B~~�        )��P	�U�t|O�Ar*


train_lossÈ�B���        )��P	��t|O�As*


train_loss`z�BX�S        )��P	ݝ�t|O�At*


train_lossIl�Bd        )��P	�t|O�Au*


train_loss{^�B�U��        )��P	K�t|O�Av*


train_loss�P�B�ñ�        )��P	��t|O�Aw*


train_loss�C�B����        )��P	��t|O�Ax*


train_loss�6�B�e�%        )��P	G�t|O�Ay*


train_loss*�B�-f1        )��P	�%�t|O�Az*


train_loss��B�S�K        )��P	�O�t|O�A{*


train_lossg�B�Ğ        )��P	�Z�t|O�A|*


train_lossq�BFj�~        )��P	�p�t|O�A}*


train_loss���B��        )��P	k|�t|O�A~*


train_loss;�B?:di        )��P	a��t|O�A*


train_loss��B����!       {��	��t|O�A�*


train_loss�׀B]�J[!       {��	m��t|O�A�*


train_loss̀B�άJ!       {��	�t|O�A�*


train_losstB΢Y�!       {��	��t|O�A�*


train_loss��B����!       {��	B͠t|O�A�*


train_lossͭ�BȇP�!       {��	�֠t|O�A�*


train_lossţ�B<^�!       {��	��t|O�A�*


train_loss뙀B.�C!       {��	��t|O�A�*


train_lossB��B��dH!       {��	��t|O�A�*


train_lossƆ�BZ�G!       {��	;�t|O�A�*


train_lossu}�BI��!       {��	�5�t|O�A�*


train_lossPt�Bo�B�!       {��	,J�t|O�A�*


train_lossVk�B����!       {��	�Y�t|O�A�*


train_loss�b�B$kң!       {��	Yh�t|O�A�*


train_loss�Y�B�I�!       {��	`w�t|O�A�*


train_lossXQ�Bd2��!       {��	䅡t|O�A�*


train_loss�H�BG\�!       {��	U��t|O�A�*


train_loss�@�Ba��!       {��	�ϡt|O�A�*


train_loss�8�Bk��!       {��	~ܡt|O�A�*


train_loss�0�B�!       {��	��t|O�A�*


train_loss�(�B��ȁ!       {��	��t|O�A�*


train_lossF!�B���z!       {��	���t|O�A�*


train_loss��BͼB�!       {��	��t|O�A�*


train_lossN�B�7%d!       {��	I�t|O�A�*


train_loss�B�Y��!       {��	~�t|O�A�*


train_loss��B,���!       {��	�.�t|O�A�*


train_loss��BY��!       {��	�=�t|O�A�*


train_loss��B��!       {��	�L�t|O�A�*


train_loss��Bð��!       {��	SY�t|O�A�*


train_lossk�B&1�[!       {��	�c�t|O�A�*


train_loss&�BJ��V!       {��	Tn�t|O�A�*


train_loss�B��y:!       {��	5z�t|O�A�*


train_loss4�B�	�v!       {��	���t|O�A�*


train_loss��B�<w!       {��	���t|O�A�*


train_loss�B|H|;!       {��	s��t|O�A�*


train_loss��B�2�!       {��	ޱ�t|O�A�*


train_loss�wB��W!       {��	�̢t|O�A�*


train_loss�kB����!       {��	?�t|O�A�*


train_loss�_By��(!       {��	^J�t|O�A�*


train_loss1TBO[N!       {��	 \�t|O�A�*


train_loss�HB���!       {��	�h�t|O�A�*


train_lossg=B6�� !       {��	�t�t|O�A�*


train_loss@2B��R�!       {��	,��t|O�A�*


train_loss>'BQ%/!       {��	6��t|O�A�*


train_loss`B����!       {��		��t|O�A�*


train_loss�B�íU!       {��	k��t|O�A�*


train_lossB��Q�!       {��	�ģt|O�A�*


train_loss��~B��|!       {��	�ϣt|O�A�*


train_lossM�~Bn��d!       {��	�ܣt|O�A�*


train_loss �~BdH�w!       {��	)�t|O�A�*


train_loss�~B�%}�!       {��	>�t|O�A�*


train_loss�~BMx"�!       {��	��t|O�A�*


train_lossF�~B���&!       {��	 �t|O�A�*


train_loss��~B��Fv!       {��	[+�t|O�A�*


train_loss��~B�^�!       {��	~:�t|O�A�*


train_loss}�~B`��!       {��	�D�t|O�A�*


train_loss�~B� ,5!       {��	3N�t|O�A�*


train_lossԚ~B{?��!       {��	!Z�t|O�A�*


train_loss��~B����!       {��	'f�t|O�A�*


train_loss��~BS-�!       {��	>t�t|O�A�*


train_loss�~B���!       {��	@��t|O�A�*


train_loss�v~B�dD�!       {��	��t|O�A�*


train_loss�m~B��E�!       {��	_��t|O�A�*


train_loss?e~B�T!       {��	H��t|O�A�*


train_loss�\~B�M�#!       {��	���t|O�A�*


train_lossT~B2�!       {��	*Ǥt|O�A�*


train_loss�K~Bq,!       {��	�٤t|O�A�*


train_lossOC~B�A�!       {��	l�t|O�A�*


train_loss;~Bn��m!       {��	Q��t|O�A�*


train_loss�2~B�w�!       {��	F�t|O�A�*


train_loss�*~B����!       {��	4/�t|O�A�*


train_loss�"~B�[%�!       {��	�J�t|O�A�*


train_loss�~B�C�!       {��	A^�t|O�A�*


train_loss�~B����!       {��	�Ʀt|O�A�*


train_loss�
~BI�CR!       {��	�ئt|O�A�*


train_loss$~B|�!       {��	}�t|O�A�*


train_losso�}B�ӽ!       {��	��t|O�A�*


train_loss��}Bn��}!       {��	��t|O�A�*


train_loss6�}BV_�!       {��	��t|O�A�*


train_loss��}B�x!       {��	�%�t|O�A�*


train_loss=�}B7���!       {��	H1�t|O�A�*


train_loss��}BU��A!       {��	#K�t|O�A�*


train_lossz�}B�g7�!       {��	�]�t|O�A�*


train_loss0�}Bh+�t!       {��	�m�t|O�A�*


train_loss��}B���!       {��	�|�t|O�A�*


train_lossŸ}B{?��!       {��	���t|O�A�*


train_loss��}B=aI�!       {��	���t|O�A�*


train_loss��}BF� !       {��	/��t|O�A�*


train_loss��}B��^{!       {��	[��t|O�A�*


train_loss��}B�>?!       {��	�Ƨt|O�A�*


train_loss��}ByM��!       {��	�ڧt|O�A�*


train_loss��}B~ٲ�!       {��	�t|O�A�*


train_lossڇ}BJXh8!       {��	���t|O�A�*


train_loss�}BLI�!       {��	�t|O�A�*


train_lossIz}BS5\H!       {��	��t|O�A�*


train_loss�s}B,E8!       {��	��t|O�A�*


train_loss�l}B�Ρ\!       {��	�0�t|O�A�*


train_loss>f}B��vN!       {��	�=�t|O�A�*


train_loss�_}BUB�!       {��	�N�t|O�A�*


train_lossY}B���!       {��	5a�t|O�A�*


train_loss�R}B����!       {��	�u�t|O�A�*


train_lossL}B�h�!       {��	z��t|O�A�*


train_loss�E}B:l�!       {��	%��t|O�A�*


train_loss1?}B��Q�!       {��	פ�t|O�A�*


train_loss�8}B���!       {��	��t|O�A�*


train_losst2}BO���!       {��	��t|O�A�*


train_loss#,}Bb�Xd!       {��	Sͨt|O�A�*


train_loss�%}B;'�!       {��	�ڨt|O�A�*


train_loss�}Bg�Y�!       {��	}�t|O�A�*


train_loss\}B��c!       {��	v��t|O�A�*


train_loss*}B,û�!       {��	S�t|O�A�*


train_loss }B��!       {��	
�t|O�A�*


train_loss�}B��<�!       {��	S$�t|O�A�*


train_loss� }B��h�!       {��	+3�t|O�A�*


train_loss��|Bf!       {��	�H�t|O�A�*


train_loss��|B�I�!       {��	�a�t|O�A�*


train_loss��|B$1R�!       {��	Lp�t|O�A�*


train_loss��|Bm���!       {��	倩t|O�A�*


train_loss��|B`)�F!       {��	���t|O�A�*


train_loss��|B��e!       {��	w��t|O�A�*


train_loss��|B�t�U!       {��	%��t|O�A�*


train_loss��|Bp��!       {��	~��t|O�A�*


train_loss��|B��lZ!       {��	ͩt|O�A�*


train_loss�|B�~2�!       {��	j۩t|O�A�*


train_loss.�|B6�!       {��	��t|O�A�*


train_loss[�|B���2!       {��	V��t|O�A�*


train_loss��|B����!       {��	O�t|O�A�*


train_lossǭ|B�s`!       {��	�t|O�A�*


train_loss�|B]g��!       {��	��t|O�A�*


train_lossF�|B��R�!       {��	�+�t|O�A�*


train_loss��|B��!       {��	�7�t|O�A�*


train_lossږ|B�;�1!       {��	�@�t|O�A�*


train_loss-�|B��A!       {��	mX�t|O�A�*


train_loss��|B�f_g!       {��	�k�t|O�A�*


train_loss߅|B�n"!       {��	px�t|O�A�*


train_loss:�|Bn|-f!       {��	s��t|O�A�*


train_loss�z|B�d�!       {��	\��t|O�A�*


train_lossu|BF�R!       {��	0��t|O�A�*


train_losspo|Bq�K!       {��	\��t|O�A�*


train_loss�i|B���!       {��	���t|O�A�*


train_lossUd|B�V]�!       {��	GǪt|O�A�*


train_loss�^|B��C�!       {��	�ժt|O�A�*


train_lossKY|Bd��C!       {��	��t|O�A�*


train_loss�S|B$�,F!       {��	�t|O�A�*


train_lossNN|B&ۄ!       {��	;��t|O�A�*


train_loss�H|Bg�!       {��	��t|O�A�*


train_loss`C|B<�c!       {��	I�t|O�A�*


train_loss�=|B5&�!       {��	��t|O�A�*


train_loss�8|B��eB!       {��	$�t|O�A�*


train_loss3|B%��!       {��	4,�t|O�A�*


train_loss�-|Bu�G�!       {��	7�t|O�A�*


train_lossM(|Be�x!       {��	tF�t|O�A�*


train_loss�"|B#���!       {��	R�t|O�A�*


train_loss�|B0���!       {��	�Y�t|O�A�*


train_loss7|BJO��!       {��	�h�t|O�A�*


train_loss�|B;��2!       {��	؂�t|O�A�*


train_loss�|B��)!       {��	2��t|O�A�*


train_loss;|Bzf�!       {��	��t|O�A�*


train_loss�|B/�d!       {��	S��t|O�A�*


train_loss��{BaA�!       {��	���t|O�A�*


train_loss\�{Bp�
!       {��	īt|O�A�*


train_loss�{B�c!       {��	-Ыt|O�A�*


train_loss��{B;!�!       {��	Mګt|O�A�*


train_loss��{B8��!       {��	��t|O�A�*


train_lossW�{B�K�O!       {��	��t|O�A�*


train_loss�{B�ޞ�!       {��	��t|O�A�*


train_loss��{BQ\��!       {��	&��t|O�A�*


train_loss��{B`w{2!       {��	��t|O�A�*


train_loss�{B�I!       {��	b�t|O�A�*


train_lossO�{BS��!       {��	`�t|O�A�*


train_loss#�{B`��L!       {��	�%�t|O�A�*


train_loss��{B�FV@!       {��	�,�t|O�A�*


train_lossϹ{B8�8�!       {��	�5�t|O�A�*


train_loss��{B��U!       {��	�t|O�A�*


train_loss��{B(�!       {��	v�t|O�A�*


train_lossc�{B�R��!       {��	��t|O�A�*


train_lossD�{Bs��!       {��	*�t|O�A�*


train_loss'�{B���!       {��	+5�t|O�A�*


train_loss�{B���!       {��	�?�t|O�A�*


train_loss�{B�:*{!       {��	�I�t|O�A�*


train_lossސ{B��j!       {��	�Q�t|O�A�*


train_lossʋ{B֢��!       {��	q[�t|O�A�*


train_loss��{B��#!       {��	�d�t|O�A�*


train_loss��{B��!       {��	�n�t|O�A�*


train_loss�|{B?Q�;!       {��	h{�t|O�A�*


train_loss�w{B�^s!       {��	▭t|O�A�*


train_loss�r{B,$!       {��	���t|O�A�*


train_loss{m{B��+B!       {��	���t|O�A�*


train_lossuh{B;io]!       {��	8��t|O�A�*


train_losspc{Bg�_!       {��	h̭t|O�A�*


train_losso^{B��-!       {��	kխt|O�A�*


train_lossoY{B%�4�!       {��	*�t|O�A�*


train_lossnT{B#��!       {��	��t|O�A�*


train_losssO{B��!       {��	��t|O�A�*


train_lossxJ{B�j�!       {��	D��t|O�A�*


train_loss�E{B"'TH!       {��	��t|O�A�*


train_loss�@{B^��!       {��	�	�t|O�A�*


train_loss�;{BU�]!       {��	A�t|O�A�*


train_loss�6{Be9G!       {��	�t|O�A�*


train_loss�1{By"v�!       {��	� �t|O�A�*


train_loss�,{BF���!       {��	+�t|O�A�*


train_loss�'{Bͮ��!       {��	]3�t|O�A�*


train_loss�"{B)�!       {��	?�t|O�A�*


train_loss�{B�10�!       {��	I�t|O�A�*


train_loss{B+i!       {��	P�t|O�A�*


train_loss&{BbJ2q!       {��	!V�t|O�A�*


train_loss@{Ba)q�!       {��	\�t|O�A�*


train_lossW
{B����!       {��	�b�t|O�A�*


train_lossv{B(��B!       {��	�j�t|O�A�*


train_loss� {Bݠ�\!       {��	�t�t|O�A�*


train_loss��zB=��{!       {��	�|�t|O�A�*


train_loss��zB-��!       {��	j��t|O�A�*


train_loss��zBJ���!       {��	A��t|O�A�*


train_loss�zB[$�!       {��	7��t|O�A�*


train_lossG�zB���!       {��	̲�t|O�A�*


train_losso�zB�17!       {��	{��t|O�A�*


train_loss��zB�ѓ�!       {��	1ˮt|O�A�*


train_loss��zBX�4!       {��	�ٮt|O�A�*


train_loss��zBx�Q!       {��	��t|O�A�*


train_loss�zB�J��!       {��	�t|O�A�*


train_lossH�zB� �A!       {��	q��t|O�A�*


train_lossy�zBHG�!       {��	��t|O�A�*


train_loss��zB3�ҋ!       {��	r�t|O�A�*


train_loss�zB]��<!       {��	��t|O�A�*


train_loss�zB���!       {��	�#�t|O�A�*


train_lossK�zB�k�!       {��	-�t|O�A�*


train_loss��zB'�!       {��	�4�t|O�A�*


train_loss��zB�e�!       {��	�<�t|O�A�*


train_loss��zB/]�!       {��	9G�t|O�A�*


train_loss2�zB`(R�!       {��	P�t|O�A�*


train_lossm�zB���!       {��	:[�t|O�A�*


train_loss��zBv[!       {��	�e�t|O�A�*


train_loss�zBE��!       {��	n�t|O�A�*


train_loss/�zB��\�!       {��	�t�t|O�A�*


train_lossp�zB�
�!       {��	�}�t|O�A�*


train_loss��zBՈ�!       {��	'��t|O�A�*


train_loss�~zB<��D!       {��	~��t|O�A�*


train_loss?zzB]�m�!       {��	-��t|O�A�*


train_loss�uzB���C!       {��	��t|O�A�*


train_loss�pzB���!       {��	
��t|O�A�*


train_losslzBND�Y!       {��	�ίt|O�A�*


train_lossdgzB2p�"!       {��	�ۯt|O�A�*


train_loss�bzBM-�!       {��	��t|O�A�*


train_loss ^zB�\J!       {��	��t|O�A�*


train_lossMYzBTc�9!       {��	-	�t|O�A�*


train_loss�TzBN�!       {��	7�t|O�A�*


train_loss�OzBA��M!       {��	�$�t|O�A�*


train_lossCKzB�q�L!       {��	�0�t|O�A�*


train_loss�FzB��b!       {��	�<�t|O�A�*


train_loss�AzB+�,N!       {��	#L�t|O�A�*


train_lossC=zBd��|!       {��	c�t|O�A�*


train_loss�8zB|�!!       {��	�q�t|O�A�*


train_loss�3zB�9L8!       {��	�|�t|O�A�*


train_lossN/zB��!       {��	+��t|O�A�*


train_loss�*zB��G!       {��	���t|O�A�*


train_loss&zBK���!       {��	A��t|O�A�*


train_lossd!zB��v�!       {��	n��t|O�A�*


train_loss�zB�&� !       {��	1��t|O�A�*


train_loss zB���!       {��	5Ұt|O�A�*


train_loss�zB�4��!       {��	�߰t|O�A�*


train_loss�zB���*!       {��	)�t|O�A�*


train_lossH
zBo���!       {��	2��t|O�A�*


train_loss�zB�s$!       {��	�
�t|O�A�*


train_losszB��u!       {��	U�t|O�A�*


train_lossz�yB^�#g!       {��	W"�t|O�A�*


train_loss��yBn>��!       {��	�/�t|O�A�*


train_lossK�yB�0��!       {��	G9�t|O�A�*


train_loss��yBy�ð!       {��	}A�t|O�A�*


train_loss �yB�H!       {��	�M�t|O�A�*


train_loss��yB��~!       {��	�X�t|O�A�*


train_loss��yB���!       {��	c�t|O�A�*


train_lossj�yBZ���!       {��	@m�t|O�A�*


train_loss��yB?��!       {��	�x�t|O�A�*


train_lossM�yB��2�!       {��	�i�t|O�A�*


train_loss��yB|Bu�!       {��	�|�t|O�A�*


train_loss2�yB���L!       {��	v��t|O�A�*


train_loss��yB<h"!       {��	���t|O�A�*


train_loss�yB����!       {��	���t|O�A�*


train_loss��yB܀�!       {��	l��t|O�A�*


train_loss
�yB���!       {��	���t|O�A�*


train_loss��yBB��!       {��	��t|O�A�*


train_loss��yB��V!       {��	Pòt|O�A�*


train_lossw�yB%=r�!       {��	Oʲt|O�A�*


train_loss��yB�=��!       {��	9زt|O�A�*


train_lossq�yB�0H*!       {��	K�t|O�A�*


train_loss�yBg`*0!       {��	k��t|O�A�*


train_lossn�yB�'w!       {��	z�t|O�A�*


train_loss�yB�aE}!       {��	I�t|O�A�*


train_losso�yB�r!       {��	y�t|O�A�*


train_loss��yB�dCg!       {��	^)�t|O�A�*


train_lossu�yB3��!       {��	H8�t|O�A�*


train_loss��yB�w�!       {��	qA�t|O�A�*


train_loss�}yB��H!       {��	�J�t|O�A�*


train_lossyyBu�!       {��	�V�t|O�A�*


train_loss�tyBH���!       {��	�c�t|O�A�*


train_losspyB����!       {��	@l�t|O�A�*


train_loss�kyBxM �!       {��	�t�t|O�A�*


train_loss.gyB�"!�!       {��	���t|O�A�*


train_loss�byB=�g�!       {��	Y��t|O�A�*


train_lossE^yBم!       {��	:��t|O�A�*


train_loss�YyB��Z�!       {��	��t|O�A�*


train_lossdUyBÐ��!       {��	稳t|O�A�*


train_loss�PyB]�W�!       {��	���t|O�A�*


train_loss�LyB֠g�!       {��	���t|O�A�*


train_lossHyBp��!       {��	qƳt|O�A�*


train_loss�CyB0pc!       {��	�ϳt|O�A�*


train_lossA?yB]��!       {��	�ڳt|O�A�*


train_loss�:yB-� !       {��	��t|O�A�*


train_lossh6yB>M��!       {��	��t|O�A�*


train_loss2yBǽ�!       {��	� �t|O�A�*


train_loss�-yBsF"V!       {��	p�t|O�A�*


train_loss3)yBtt>�!       {��	]�t|O�A�*


train_loss�$yBI�H!       {��	�%�t|O�A�*


train_lossi yB�⸝!       {��	]3�t|O�A�*


train_lossyBN�s6!       {��	`@�t|O�A�*


train_loss�yBE}�!       {��	�L�t|O�A�*


train_lossAyBoV�<!       {��	W�t|O�A�*


train_loss�yB���)!       {��	d`�t|O�A�*


train_loss�
yB��A!       {��	k�t|O�A�*


train_loss"yBv�i!       {��	�s�t|O�A�*


train_loss�yB �D�!       {��	�{�t|O�A�*


train_lossj�xB�5V�!       {��	^��t|O�A�*


train_loss�xB�F� !       {��	��t|O�A�*


train_loss��xBNtP�!       {��	���t|O�A�*


train_lossV�xB=��!       {��	��t|O�A�*


train_loss��xB��~!       {��	J��t|O�A�*


train_loss��xB�!       {��	A��t|O�A�*


train_lossP�xB�ac�!       {��	�´t|O�A�*


train_loss��xB�!       {��	ɴt|O�A�*


train_loss��xB�/9�!       {��	hдt|O�A�*


train_lossR�xB('�p!       {��	�ٴt|O�A�*


train_loss �xB_�!       {��	]�t|O�A�*


train_loss��xB@��!       {��	��t|O�A�*


train_loss\�xB�Q��!       {��	Z�t|O�A�*


train_loss�xB�u!       {��	���t|O�A�*


train_loss��xB��d@!       {��	:�t|O�A�*


train_lossp�xB�O߲!       {��	��t|O�A�*


train_loss#�xB�z-�!       {��	O�t|O�A�*


train_lossڳxBGB�?!       {��	�'�t|O�A�*


train_loss��xB����!       {��	�3�t|O�A�*


train_lossC�xB*�.!       {��	�G�t|O�A�*


train_loss��xB~��&!       {��	�U�t|O�A�*


train_loss��xB��A!       {��	,c�t|O�A�*


train_lossj�xB�	!       {��	�p�t|O�A�*


train_loss#�xB��d�!       {��	�{�t|O�A�*


train_lossݕxB�m{b!       {��	'��t|O�A�*


train_loss��xB���3!       {��	���t|O�A�*


train_lossW�xB�7N!       {��	|��t|O�A�*


train_loss�xB�t�!       {��	e��t|O�A�*


train_loss҄xB�:�!       {��	_��t|O�A�*


train_loss��xB�p;<!       {��	ŵt|O�A�*


train_lossR|xB����!       {��	)ϵt|O�A�*


train_lossxxB	 � !       {��	g׵t|O�A�*


train_loss�sxBt�!       {��	�޵t|O�A�*


train_loss�oxB\���!       {��	6�t|O�A�*


train_loss]kxB<�=I!       {��	h��t|O�A�*


train_loss"gxB0��n!       {��	��t|O�A�*


train_loss�bxBӝ�!       {��	q�t|O�A�*


train_loss�^xB׃�!       {��	+�t|O�A�*


train_losswZxBmg0�!       {��	|&�t|O�A�*


train_lossAVxB��8�!       {��	P6�t|O�A�*


train_lossRxB��\!       {��	�C�t|O�A�*


train_loss�MxB��~�!       {��	�V�t|O�A�*


train_loss�IxB�ò!       {��	oe�t|O�A�*


train_lossnExB±%�!       {��	�r�t|O�A�*


train_loss:AxB�4!       {��	�~�t|O�A�*


train_loss=xB�q�#!       {��	��t|O�A�*


train_loss�8xB��[!       {��	=��t|O�A�*


train_loss�4xB�Њ�!       {��	���t|O�A�*


train_lossy0xB�?ͼ!       {��	���t|O�A�*


train_lossL,xBX�Ź!       {��	���t|O�A�*


train_loss (xBZw��!       {��	�˶t|O�A�*


train_loss�#xB�b6�!       {��	�ڶt|O�A�*


train_loss�xB J? !       {��	D�t|O�A�*


train_loss�xB��!       {��	�#�t|O�A�*


train_losstxB��"!       {��	+2�t|O�A�*


train_lossLxB� \�!       {��	�K�t|O�A�*


train_loss$xB�7�U!       {��	�^�t|O�A�*


train_loss�
xBR���!       {��	r�t|O�A�*


train_loss�xB�-��!       {��	��t|O�A�*


train_loss�xB�L�!       {��	��t|O�A�*


train_loss��wB" !       {��	��t|O�A�*


train_lossl�wB�旑!       {��	���t|O�A�*


train_lossK�wB�:!       {��	�ʸt|O�A�*


train_loss)�wB�&WA!       {��	ڸt|O�A�*


train_loss�wB���!       {��	��t|O�A�*


train_loss��wB2�%�!       {��	�t|O�A�*


train_loss��wB$�F�!       {��	��t|O�A�*


train_loss��wBG�'�!       {��	�$�t|O�A�*


train_loss��wB�r,!       {��	�0�t|O�A�*


train_lossv�wB��^�!       {��	KW�t|O�A�*


train_loss[�wB�L��!       {��	�f�t|O�A�*


train_lossA�wBn�7'!       {��	�y�t|O�A�*


train_loss)�wB��y�!       {��	���t|O�A�*


train_loss�wBuL�!       {��	���t|O�A�*


train_loss��wB���!       {��	���t|O�A�*


train_loss��wBH�5c!       {��	���t|O�A�*


train_loss̼wB�d��!       {��	-ιt|O�A�*


train_loss��wB�M�P!       {��	�ܹt|O�A�*


train_loss��wBkRa!       {��	��t|O�A�*


train_loss��wB����!       {��	���t|O�A�*


train_loss�wB�
�!       {��	�
�t|O�A�*


train_losso�wB�30!       {��	�t|O�A�*


train_loss_�wB����!       {��	K!�t|O�A�*


train_lossP�wB'�(!       {��	�*�t|O�A�*


train_lossD�wB���!       {��	U5�t|O�A�*


train_loss2�wB&�q�!       {��	!>�t|O�A�*


train_loss&�wB>�M�!       {��	4I�t|O�A�*


train_loss�wB��k�!       {��	�\�t|O�A�*


train_loss�wB�B��!       {��	�p�t|O�A�*


train_loss�wB\���!       {��	�~�t|O�A�*


train_loss��wB���q!       {��	;��t|O�A�*


train_loss�wBhX1l!       {��	읺t|O�A�*


train_loss�{wB�#�N!       {��	}��t|O�A�*


train_loss�wwB����!       {��	ǿ�t|O�A�*


train_loss�swBI��!       {��	�κt|O�A�*


train_loss�owBT,2�!       {��	zܺt|O�A�*


train_loss�kwBWI�!       {��	)�t|O�A�*


train_loss�gwB�}��!       {��	���t|O�A�*


train_loss�cwBA3�!       {��	�
�t|O�A�*


train_loss�_wB���_!       {��	L�t|O�A�*


train_loss�[wBIO��!       {��	t&�t|O�A�*


train_loss�WwB�#�5!       {��	�5�t|O�A�*


train_loss�SwB6_d�!       {��	_A�t|O�A�*


train_loss�OwB.WR!       {��	�K�t|O�A�*


train_loss�KwBDg��!       {��	�W�t|O�A�*


train_loss�GwB�}I�!       {��	�a�t|O�A�*


train_loss�CwB�}�!       {��	,{�t|O�A�*


train_loss�?wB��!       {��	X��t|O�A�*


train_loss�;wB��!       {��	A��t|O�A�*


train_loss�7wBĵ!       {��	���t|O�A�*


train_loss�3wBaH !       {��	ع�t|O�A�*


train_loss0wB֯f!       {��	*ƻt|O�A�*


train_loss,wBBa��!       {��	5Իt|O�A�*


train_loss(wB��!       {��	G�t|O�A�*


train_loss'$wB>��`!       {��	��t|O�A�*


train_loss3 wB4�4!       {��	���t|O�A�*


train_loss@wB�L�!       {��	�
�t|O�A�*


train_lossNwB����!       {��	{�t|O�A�*


train_loss]wB37��!       {��	�"�t|O�A�*


train_lossmwB��D�!       {��	�,�t|O�A�*


train_loss|wBE��!       {��	37�t|O�A�*


train_loss�wB��c�!       {��	�A�t|O�A�*


train_loss�wB$E?!       {��	(L�t|O�A�*


train_loss� wB�H}!       {��	W�t|O�A�*


train_loss��vB@��!       {��	�a�t|O�A�*


train_loss��vBa��V!       {��	�q�t|O�A�*


train_loss��vB� !       {��	.��t|O�A�*


train_loss	�vBJlE�!       {��	���t|O�A�*


train_loss�vBh�!       {��	���t|O�A�*


train_loss7�vB�ۋ_!       {��	 ��t|O�A�*


train_lossO�vB�Kܯ!       {��	�Ǽt|O�A�*


train_lossi�vB1&��!       {��	<ؼt|O�A�*


train_loss��vB�d�!       {��	P�t|O�A�*


train_loss��vB@� �!       {��	W�t|O�A�*


train_loss��vB�3�A!       {��	�t|O�A�*


train_loss��vB|��!       {��	(�t|O�A�*


train_loss��vB��{�!       {��	Y�t|O�A�*


train_loss�vBK.�!       {��	� �t|O�A�*


train_loss8�vBh��!       {��	�(�t|O�A�*


train_lossV�vB���!       {��	=0�t|O�A�*


train_lossw�vB�5 !       {��	~:�t|O�A�*


train_loss��vB�!       {��	D�t|O�A�*


train_loss��vB"�!       {��	�R�t|O�A�*


train_loss�vB���!       {��	�]�t|O�A�*


train_loss�vB�>C!       {��	oh�t|O�A�*


train_loss*�vBb�,�!       {��	q�t|O�A�*


train_lossQ�vBP���!       {��	�z�t|O�A�*


train_lossy�vBg�!       {��	��t|O�A�*


train_loss��vB��!       {��	1��t|O�A�*


train_lossǛvB: ��!       {��	���t|O�A�*


train_loss�vB�|�!       {��	д�t|O�A�*


train_loss�vBH\h!       {��	;½t|O�A�*


train_lossF�vB;���!       {��	�Ⱦt|O�A�*


train_losss�vBZ�i�!       {��	׾t|O�A�*


train_loss��vB��	�!       {��	S�t|O�A�*


train_loss̄vB���!       {��	���t|O�A�*


train_loss��vB��R!       {��	� �t|O�A�*


train_loss(}vB�8!       {��	��t|O�A�*


train_lossZyvB���!       {��	��t|O�A�*


train_loss�uvB�{��!       {��	��t|O�A�*


train_loss�qvBY#�!       {��	<.�t|O�A�*


train_loss�mvB#�E�!       {��	�>�t|O�A�*


train_loss!jvB,��!       {��	�I�t|O�A�*


train_lossSfvB��'!       {��	�R�t|O�A�*


train_loss�bvB��6*!       {��	>\�t|O�A�*


train_loss�^vB$.m!       {��	g�t|O�A�*


train_loss�ZvB,�q�!       {��	zp�t|O�A�*


train_loss-WvBm=q�!       {��	%z�t|O�A�*


train_lossdSvB7P9,!       {��	ԁ�t|O�A�*


train_loss�OvB^�1!       {��	���t|O�A�*


train_loss�KvBxUk�!       {��	���t|O�A�*


train_lossHvB�8��!       {��	��t|O�A�*


train_lossLDvB����!       {��	2��t|O�A�*


train_loss�@vB����!       {��	A��t|O�A�*


train_loss�<vB6H0!       {��	e¿t|O�A�*


train_loss9vB4_u)!       {��	OͿt|O�A�*


train_loss@5vB�b��!       {��	nؿt|O�A�*


train_loss~1vB�k�=!       {��	��t|O�A�*


train_loss�-vB����!       {��	��t|O�A�*


train_loss�)vB�I!       {��	��t|O�A�*


train_lossA&vB�a��!       {��		�t|O�A�*


train_loss�"vB����!       {��	��t|O�A�*


train_loss�vB�i�G!       {��	��t|O�A�*


train_loss	vB�%�)!       {��	�'�t|O�A�*


train_lossNvBR?Pv!       {��	�4�t|O�A�*


train_loss�vB�?�!       {��	)>�t|O�A�*


train_loss�vBݗ�!       {��	�F�t|O�A�*


train_lossvB�ʜ�!       {��	�Q�t|O�A�*


train_lossgvB��Z0!       {��	[�t|O�A�*


train_loss�vB�c�[!       {��	Jc�t|O�A�*


train_loss� vB�;�!       {��	�l�t|O�A�*


train_lossB�uB�?2!       {��	�t�t|O�A�*


train_loss��uBt)�!       {��	�}�t|O�A�*


train_loss��uB7S��!       {��	w��t|O�A�*


train_loss$�uB���!       {��	z��t|O�A�*


train_losso�uB���!       {��	���t|O�A�*


train_loss��uB��!       {��	V��t|O�A�*


train_loss�uBU�z�!       {��	<��t|O�A�*


train_loss]�uB�y
!       {��	ʧ�t|O�A�*


train_loss��uB��!       {��	)��t|O�A�*


train_loss��uB�j�!       {��	��t|O�A�*


train_lossO�uB\a�!       {��	���t|O�A�*


train_loss��uB�*!       {��	���t|O�A�*


train_loss��uB�!k_!       {��	���t|O�A�*


train_lossI�uB�P�F!       {��	<��t|O�A�*


train_loss��uB�)pf!       {��	��t|O�A�*


train_loss��uB��!�!       {��	9�t|O�A�*


train_lossH�uBKDO�!       {��	S �t|O�A�*


train_loss��uB��`�!       {��	�,�t|O�A�*


train_loss��uB@R�H!       {��	SB�t|O�A�*


train_lossP�uB�/v!       {��	�O�t|O�A�*


train_loss��uBv�4�!       {��	O^�t|O�A�*


train_loss�uBB���!       {��	{i�t|O�A�*


train_loss]�uB:]�,!       {��	?s�t|O�A�*


train_loss��uB���F!       {��	�}�t|O�A�*


train_loss�uB�h!       {��	���t|O�A�*


train_losss�uB =~*!       {��	��t|O�A�*


train_lossΝuB��N!       {��	���t|O�A�*


train_loss-�uB |�G!       {��	~��t|O�A�*


train_loss��uB�y(!       {��	��t|O�A�*


train_loss�uB����!       {��	Z��t|O�A�*


train_lossN�uBd�P!       {��	h��t|O�A�*


train_loss��uB�cտ!       {��	f��t|O�A�*


train_loss�uBA�>!       {��	��t|O�A�*


train_losst�uB]��!       {��	���t|O�A�*


train_loss؀uB�s!       {��	e��t|O�A�*


train_loss>}uB�и^!       {��	�t|O�A�*


train_loss�yuB��e�!       {��	�t|O�A�*


train_lossvuB�i�&!       {��	#�t|O�A�*


train_lossnruB��P�!       {��	^.�t|O�A�*


train_loss�nuB]�߰!       {��	�9�t|O�A�*


train_loss>kuBդ��!       {��	_F�t|O�A�*


train_loss�guB��I!       {��	/Q�t|O�A�*


train_lossduBmL��!       {��	W_�t|O�A�*


train_lossz`uB�pA!       {��	�j�t|O�A�*


train_loss�\uB�=!       {��	v�t|O�A�*


train_lossQYuB>�I�!       {��	~�t|O�A�*


train_loss�UuB��iM!       {��	���t|O�A�*


train_loss*RuB���>!       {��	���t|O�A�*


train_loss�NuB3�*�!       {��	R��t|O�A�*


train_loss	KuBaeT!       {��	���t|O�A�*


train_lossxGuBs� !       {��	֮�t|O�A�*


train_loss�CuB��!       {��	���t|O�A�*


train_lossY@uBu��J!       {��	��t|O�A�*


train_loss�<uB����!       {��	.��t|O�A�*


train_loss<9uB�,��!       {��	S��t|O�A�*


train_loss�5uBO��n!       {��	���t|O�A�*


train_loss$2uB�$��!       {��	���t|O�A�*


train_loss�.uB�*��!       {��	��t|O�A�*


train_loss+uB��!       {��	3��t|O�A�*


train_loss�'uBkQz�!       {��	O�t|O�A�*


train_loss�#uB�#��!       {��	��t|O�A�*


train_lossr uB�}@�!       {��	M��t|O�A�*


train_loss�uB¸��!       {��	�	�t|O�A�*


train_lossbuB@[� !       {��	��t|O�A�*


train_loss�uBA�|!       {��	�"�t|O�A�*


train_lossVuB�6C�!       {��	�-�t|O�A�*


train_loss�uB;(o�!       {��	�=�t|O�A�*


train_lossOuBA�
!       {��	_H�t|O�A�*


train_loss�uBu�,!       {��	~Q�t|O�A�*


train_lossGuBB*�!       {��	Y�t|O�A�*


train_loss� uB@��!       {��	4d�t|O�A�*


train_lossA�tB.�!       {��	Dk�t|O�A�*


train_loss��tB��A!       {��	Ks�t|O�A�*


train_lossC�tB�׭�!       {��	 |�t|O�A�*


train_loss��tB�W}"!       {��	U��t|O�A�*


train_lossF�tB�ԑ�!       {��	��t|O�A�*


train_loss��tBg�!       {��	(��t|O�A�*


train_lossJ�tB��Y!       {��	U��t|O�A�*


train_loss��tB�v��!       {��	C��t|O�A�*


train_lossR�tB��D!       {��	=��t|O�A�*


train_loss��tB�&�!       {��	2��t|O�A�*


train_loss]�tB���!       {��	!��t|O�A�*


train_loss��tB��I!       {��	M��t|O�A�*


train_lossi�tBR>�!       {��	���t|O�A�*


train_loss��tBѼ�!       {��	��t|O�A�*


train_lossy�tB��.!       {��	���t|O�A�*


train_loss�tB�� �!       {��	+��t|O�A�*


train_loss��tB�t��!       {��	*�t|O�A�*


train_loss�tBS��!       {��	M�t|O�A�*


train_loss��tBV��!       {��	*�t|O�A�*


train_loss/�tB��O�!       {��	K"�t|O�A�*


train_loss��tBjKC!       {��	�+�t|O�A�*


train_lossK�tBb���!       {��	�3�t|O�A�*


train_lossְtB�JT�!       {��	q<�t|O�A�*


train_lossf�tB�(��!       {��	C�t|O�A�*


train_loss��tBpz�!       {��	�J�t|O�A�*


train_loss��tB6���!       {��	<S�t|O�A�*


train_loss�tBU6!       {��	�Y�t|O�A�*


train_loss��tB�*�!       {��	�`�t|O�A�*


train_loss:�tB��?!       {��	�f�t|O�A�*


train_loss̘tBE�(�!       {��	�m�t|O�A�*


train_loss`�tB���!       {��	Kt�t|O�A�*


train_loss��tB��W!       {��	�z�t|O�A�*


train_loss��tB����!       {��	8��t|O�A�*


train_loss�tB��Ѡ!       {��	߇�t|O�A�*


train_loss��tB�#�J!       {��	G��t|O�A�*


train_lossL�tB��!       {��	��t|O�A�*


train_loss�tBX17!       {��	���t|O�A�*


train_loss}}tB�?`!       {��	<��t|O�A�*


train_lossztBվ�=!       {��	ͪ�t|O�A�*


train_loss�vtB&��!       {��	���t|O�A�*


train_lossJstBZ�k�!       {��	��t|O�A�*


train_loss�otB�8��!       {��	a��t|O�A�*


train_loss�ltB�1~!       {��	��t|O�A�*


train_lossitB�i��!       {��	���t|O�A�*


train_loss�etB${�A!       {��	���t|O�A�*


train_lossXbtB ���!       {��	��t|O�A�*


train_loss�^tB���!       {��	���t|O�A�*


train_loss�[tB]�.!       {��	���t|O�A�*


train_loss4XtB"E�R!       {��	���t|O�A�*


train_loss�TtB��+!       {��	���t|O�A�*


train_lossvQtB�S�l!       {��	���t|O�A�*


train_lossNtB<K�C!       {��	��t|O�A�*


train_loss�JtBqg!       {��	��t|O�A�*


train_loss_GtB�}�!       {��	��t|O�A�*


train_lossDtB��N'!       {��	��t|O�A�*


train_loss�@tBZ҃�!       {��	 �t|O�A�*


train_lossM=tB�.��!       {��	��t|O�A�*


train_loss�9tB�`R!       {��	�%�t|O�A�*


train_loss�6tB���!       {��	�+�t|O�A�*


train_loss@3tB�l�U!       {��	�1�t|O�A�*


train_loss�/tB�%17!       {��	�7�t|O�A�*


train_loss�,tB���!       {��	�=�t|O�A�*


train_loss8)tBX�!�!       {��	�C�t|O�A�*


train_loss�%tB��: !       {��	NI�t|O�A�*


train_loss�"tB��D!       {��	�O�t|O�A�*


train_loss:tB�5��!       {��	�U�t|O�A�*


train_loss�tB-�JD!       {��	�[�t|O�A�*


train_loss�tBE��!       {��	�a�t|O�A�*


train_loss>tB1>2@!       {��	�g�t|O�A�*


train_loss�tB~��!       {��	�m�t|O�A�*


train_loss�tBI��!       {��	�s�t|O�A�*


train_lossJtB@���!       {��	�y�t|O�A�*


train_loss�tB���%!       {��	R��t|O�A�*


train_loss�tB���!       {��	L��t|O�A�*


train_loss\tBYZ1!       {��	���t|O�A�*


train_loss�sBޔ�!       {��	[��t|O�A�*


train_loss��sBU;�T!       {��	���t|O�A�*


train_lossq�sB=E;�!       {��	ƣ�t|O�A�*


train_loss%�sBR�l!       {��	r��t|O�A�*


train_loss��sB��S�!       {��	1��t|O�A�*


train_loss��sB� �T!       {��	���t|O�A�*


train_lossE�sB���!       {��	ƾ�t|O�A�*


train_loss��sB;��!       {��	���t|O�A�*


train_loss��sBv��!       {��	9��t|O�A�*


train_lossi�sBֲۤ!       {��	���t|O�A�*


train_loss!�sB`E�|!       {��	���t|O�A�*


train_loss��sB���!       {��	��t|O�A�*


train_loss��sB��B!       {��	V��t|O�A�*


train_lossN�sBƲd�!       {��	���t|O�A�*


train_loss�sB�1�/!       {��	���t|O�A�*


train_loss��sB�3")!       {��	��t|O�A�*


train_loss��sB��.�!       {��	��t|O�A�*


train_loss?�sB}M�K!       {��	n��t|O�A�*


train_loss��sB����!       {��	���t|O�A�*


train_loss��sB��.�!       {��	��t|O�A�*


train_lossw�sB��x!       {��	���t|O�A�*


train_loss5�sBCg��!       {��	'��t|O�A�*


train_loss��sB$*5!       {��	���t|O�A�*


train_loss��sB���'!       {��	���t|O�A�*


train_lossw�sB�i��!       {��	���t|O�A�*


train_loss9�sB����!       {��	��t|O�A�*


train_loss��sBV0�!       {��	��t|O�A�*


train_loss��sB��!       {��	/�t|O�A�*


train_loss��sBuaVn!       {��	��t|O�A�*


train_lossH�sB�o\�!       {��	G$�t|O�A�*


train_loss�sB��7�!       {��	�*�t|O�A�*


train_lossӘsBm1�!       {��	2�t|O�A�*


train_loss��sB�j8!       {��	u9�t|O�A�*


train_loss`�sB��X8!       {��	�?�t|O�A�*


train_loss&�sBK,pv!       {��	AF�t|O�A�*


train_loss��sB���!       {��	�M�t|O�A�*


train_loss��sB�y6c!       {��	T�t|O�A�*


train_loss��sB��#�!       {��	�\�t|O�A�*


train_lossK�sB����!       {��	_c�t|O�A�*


train_losssB'�\�!       {��	wl�t|O�A�*


train_loss�{sB�;�!       {��	Jv�t|O�A�*


train_loss�xsBz1ա!       {��	}�t|O�A�*


train_lossyusB���!       {��	��t|O�A�*


train_lossHrsB����!       {��	���t|O�A�*


train_lossosB#�w !       {��	���t|O�A�*


train_loss�ksBՔ��!       {��	���t|O�A�*


train_loss�hsB58�7!       {��	���t|O�A�*


train_loss�esB��4 !       {��	O��t|O�A�*


train_lossSbsBR�ލ!       {��	���t|O�A�*


train_loss"_sB��Ͱ!       {��	��t|O�A�*


train_loss�[sB�t�!       {��	���t|O�A�*


train_loss�XsB)��!       {��	���t|O�A�*


train_loss�UsBB�G'!       {��	���t|O�A�*


train_lossjRsB�V�!       {��	���t|O�A�*


train_loss>OsB�%!       {��	���t|O�A�*


train_lossLsB!Gn!       {��	&��t|O�A�*


train_loss�HsB��;�!       {��	���t|O�A�*


train_loss�EsB���!       {��	���t|O�A�*


train_loss�BsB�؋!!       {��	O�t|O�A�*


train_lossk?sB*}�!       {��	,�t|O�A�*


train_lossC<sB`��=!       {��	�t|O�A�*


train_loss9sB"���!       {��	K�t|O�A�*


train_loss�5sB[��;!       {��	�"�t|O�A�*


train_loss�2sBL�p�!       {��	*�t|O�A�*


train_loss�/sB��e!       {��	b0�t|O�A�*


train_loss�,sB���!       {��	�6�t|O�A�*


train_loss^)sB����!       {��	:=�t|O�A�*


train_loss9&sB��!       {��	�C�t|O�A�*


train_loss#sB)�	!       {��	�J�t|O�A�*


train_loss�sBbɏ;!       {��	nP�t|O�A�*


train_loss�sB(�d�!       {��	vV�t|O�A�*


train_loss�sB?��R!       {��	�\�t|O�A�*


train_loss�sBJ�v1!       {��	Mc�t|O�A�*


train_lossmsBt��!       {��	k�t|O�A�*


train_lossNsB�2��!       {��	t�t|O�A�*


train_loss.sB��V!       {��	0~�t|O�A�*


train_loss
sB��I8!       {��	��t|O�A�*


train_loss�sBJ��!       {��	���t|O�A�*


train_loss�sB�B�!       {��	��t|O�A�*


train_loss� sBq��!       {��	���t|O�A�*


train_loss��rB���i!       {��	���t|O�A�*


train_loss~�rBj��!       {��	���t|O�A�*


train_lossc�rB�k�!       {��	��t|O�A�*


train_lossJ�rB4���!       {��	$��t|O�A�*


train_loss-�rB���!       {��	���t|O�A�*


train_loss�rB_E$!       {��	���t|O�A�*


train_loss��rB���!       {��	���t|O�A�*


train_loss��rB��9]!       {��	���t|O�A�*


train_loss��rB���!       {��	��t|O�A�*


train_loss��rB}�!       {��	���t|O�A�*


train_loss��rB�V�[!       {��	��t|O�A�*


train_loss��rB*3�!       {��	C�t|O�A�*


train_losss�rB�H=\!       {��	R
�t|O�A�*


train_loss^�rB�ƛ�!       {��	0�t|O�A�*


train_lossJ�rBB5A!       {��	��t|O�A�*


train_loss9�rBI8`�!       {��	�"�t|O�A�*


train_loss#�rB3ZA�!       {��	b+�t|O�A�*


train_loss�rB�4^!       {��	�2�t|O�A�*


train_loss��rBf�0!       {��	�9�t|O�A�*


train_loss��rB� w!       {��	S@�t|O�A�*


train_lossݿrB�V�<!       {��	�H�t|O�A�*


train_lossμrB.�5!       {��	qW�t|O�A�*


train_loss��rBZ^%�!       {��	�_�t|O�A�*


train_loss��rB� �r!       {��	�n�t|O�A�*


train_loss��rBԄٛ!       {��	y�t|O�A�*


train_loss��rB�Y�!       {��	���t|O�A�*


train_loss��rB��C!       {��	;��t|O�A�*


train_lossy�rB�CTE!       {��	��t|O�A�*


train_lossn�rB��~�!       {��	n��t|O�A�*


train_lossa�rBxSc�!       {��	B��t|O�A�*


train_lossX�rBU���!       {��	��t|O�A�*


train_lossM�rB�ٌ�!       {��	���t|O�A�*


train_lossB�rB[�!       {��	���t|O�A�*


train_loss9�rB���!       {��	i��t|O�A�*


train_loss2�rB� !       {��	���t|O�A�*


train_loss'�rBj���!       {��	���t|O�A�*


train_loss!�rBg�C�!       {��	~��t|O�A�*


train_loss�rB�J�!       {��	��t|O�A�*


train_loss�rB�V�Z!       {��	Z��t|O�A�*


train_loss�rB��h!       {��	#��t|O�A�*


train_loss	�rB�r�!       {��	���t|O�A�*


train_loss�rB?-l=!       {��	}��t|O�A�*


train_loss}rB�qv!       {��	 ��t|O�A�*


train_loss�yrB0�m�!       {��	���t|O�A�*


train_loss�vrB��!       {��	5�t|O�A�*


train_loss�srB4,b!       {��	��t|O�A�*


train_loss�prB��p!       {��	��t|O�A�*


train_loss�mrB���!       {��	�%�t|O�A�*


train_loss�jrB[ڔ!       {��	/�t|O�A�*


train_loss�grB�^!       {��	�7�t|O�A�*


train_loss�drB�Ş�!       {��	�?�t|O�A�*


train_loss�arB}f	!       {��	K�t|O�A�*


train_loss�^rB"Ϧ!       {��	qV�t|O�A�*


train_loss�[rB��i!       {��	h^�t|O�A�*


train_loss�XrB|dd!       {��	�f�t|O�A�*


train_loss�UrB�޿�!       {��	�n�t|O�A�*


train_lossSrB�2!       {��	�v�t|O�A�*


train_loss
PrB�nZ!       {��	��t|O�A�*


train_lossMrB���I!       {��	�t|O�A�*


train_lossJrB�}�!       {��	��t|O�A�*


train_lossGrB*E�;!       {��	z��t|O�A�*


train_loss DrB���e!       {��	��t|O�A�*


train_loss'ArBmof*!       {��	]��t|O�A�*


train_loss0>rB[Id�!       {��	���t|O�A�*


train_loss7;rBڮ��!       {��	���t|O�A�*


train_loss@8rB���!       {��	0��t|O�A�*


train_lossK5rB��!       {��	*��t|O�A�*


train_lossT2rB��ˬ!       {��	2��t|O�A�*


train_loss`/rB���=!       {��	���t|O�A�*


train_lossj,rB�~�_!       {��	Q��t|O�A�*


train_lossw)rB.&A!       {��	X��t|O�A�*


train_loss�&rB�*|-!       {��	��t|O�A�*


train_loss�#rB��s!       {��	��t|O�A�*


train_loss� rB�ua�!       {��	��t|O�A�*


train_loss�rB����!       {��	�%�t|O�A�*


train_loss�rB���!       {��	g.�t|O�A�*


train_loss�rB3�H!       {��	�6�t|O�A�*


train_loss�rB�u�!       {��	�>�t|O�A�*


train_loss�rBk
��!       {��	�E�t|O�A�*


train_loss�rB�^A�!       {��	�L�t|O�A�*


train_lossrBy� �!       {��	~S�t|O�A�*


train_loss	rB�C8!       {��	S]�t|O�A�*


train_loss,rB]�+@!       {��	�f�t|O�A�*


train_loss=rB�TP8!       {��	�n�t|O�A�*


train_lossQ r
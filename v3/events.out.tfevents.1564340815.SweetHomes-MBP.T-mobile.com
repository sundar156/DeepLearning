       �K"	  ��|O�Abrain.Event:2��#�/      �J�	���|O�A"�^
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
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*'
_output_shapes
:���������*
	keep_dims(*

Tidx0*
T0
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
Variable/AssignAssignVariableWeights*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:*
use_locking(
i
Variable/readIdentityVariable*
_output_shapes

:*
T0*
_class
loc:@Variable
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
Variable_1Bias*
use_locking(*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:
k
Variable_1/readIdentity
Variable_1*
_output_shapes
:*
T0*
_class
loc:@Variable_1
A
readIdentity
Variable_1*
T0*
_output_shapes
:
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
subSuboutputy-input*
T0*'
_output_shapes
:���������
G
SquareSquaresub*'
_output_shapes
:���������*
T0
V
ConstConst*
valueB"       *
dtype0*
_output_shapes
:
Y
LossMeanSquareConst*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
R
gradients/ShapeConst*
dtype0*
_output_shapes
: *
valueB 
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
gradients/Loss_grad/Prod_1Prodgradients/Loss_grad/Shape_2gradients/Loss_grad/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
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
gradients/Square_grad/Mul_1Mulgradients/Loss_grad/truedivgradients/Square_grad/Mul*'
_output_shapes
:���������*
T0
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
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/sub_grad/SumSumgradients/Square_grad/Mul_1(gradients/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*
	keep_dims( *

Tidx0
�
gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:���������
�
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Z
gradients/sub_grad/NegNeggradients/sub_grad/Sum_1*
_output_shapes
:*
T0
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
gradients/output_grad/Shape_1Const*
valueB:*
dtype0*
_output_shapes
:
�
+gradients/output_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/output_grad/Shapegradients/output_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*
	keep_dims( *

Tidx0
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
:*
	keep_dims( *

Tidx0
�
gradients/output_grad/Reshape_1Reshapegradients/output_grad/Sum_1gradients/output_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:
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
gradients/MatMul_grad/MatMulMatMul.gradients/output_grad/tuple/control_dependencyVariable/read*
T0*'
_output_shapes
:���������*
transpose_a( *
transpose_b(
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
GradientDescent/learning_rateConst*
dtype0*
_output_shapes
: *
valueB
 *���>
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
Variable_1GradientDescent/learning_rate0gradients/output_grad/tuple/control_dependency_1*
T0*
_class
loc:@Variable_1*
_output_shapes
:*
use_locking( 
�
GradientDescentNoOp5^GradientDescent/update_Variable/ApplyGradientDescent7^GradientDescent/update_Variable_1/ApplyGradientDescent
2
initNoOp^Variable/Assign^Variable_1/Assign
Z
train_loss/tagsConst*
dtype0*
_output_shapes
: *
valueB B
train_loss
S

train_lossScalarSummarytrain_loss/tagsLoss*
T0*
_output_shapes
: 
4
init_1NoOp^Variable/Assign^Variable_1/Assign
Y
save/filename/inputConst*
dtype0*
_output_shapes
: *
valueB Bmodel
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
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
_output_shapes

::*
dtypes
2
�
save/AssignAssignVariablesave/RestoreV2*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:*
use_locking(
�
save/Assign_1Assign
Variable_1save/RestoreV2:1*
use_locking(*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:
6
save/restore_allNoOp^save/Assign^save/Assign_1"v5���:      Uq�e	x'�|O�AJ�u
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
shape:���������*
dtype0*'
_output_shapes
:���������
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
VariableV2*
shared_name *
dtype0*
	container *
_output_shapes

:*
shape
:
�
Variable/AssignAssignVariableWeights*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:*
use_locking(
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
dtype0*
	container *
_output_shapes
:*
shape:*
shared_name 
�
Variable_1/AssignAssign
Variable_1Bias*
use_locking(*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:
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
MatMulMatMull2_normalizeVariable/read*
transpose_b( *
T0*
transpose_a( *'
_output_shapes
:���������
X
outputAddMatMulVariable_1/read*
T0*'
_output_shapes
:���������
M
subSuboutputy-input*'
_output_shapes
:���������*
T0
G
SquareSquaresub*'
_output_shapes
:���������*
T0
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
: *

Tidx0*
	keep_dims( 
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
gradients/Loss_grad/ShapeShapeSquare*
_output_shapes
:*
T0*
out_type0
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
gradients/Loss_grad/Shape_2Const*
dtype0*
_output_shapes
: *
valueB 
c
gradients/Loss_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
�
gradients/Loss_grad/ProdProdgradients/Loss_grad/Shape_1gradients/Loss_grad/Const*

Tidx0*
	keep_dims( *
T0*
_output_shapes
: 
e
gradients/Loss_grad/Const_1Const*
dtype0*
_output_shapes
:*
valueB: 
�
gradients/Loss_grad/Prod_1Prodgradients/Loss_grad/Shape_2gradients/Loss_grad/Const_1*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
gradients/sub_grad/Shape_1Shapey-input*
T0*
out_type0*
_output_shapes
:
�
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/sub_grad/SumSumgradients/Square_grad/Mul_1(gradients/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
�
gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:���������
�
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
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
gradients/output_grad/Shape_1Const*
valueB:*
dtype0*
_output_shapes
:
�
+gradients/output_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/output_grad/Shapegradients/output_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
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
.gradients/output_grad/tuple/control_dependencyIdentitygradients/output_grad/Reshape'^gradients/output_grad/tuple/group_deps*
T0*0
_class&
$"loc:@gradients/output_grad/Reshape*'
_output_shapes
:���������
�
0gradients/output_grad/tuple/control_dependency_1Identitygradients/output_grad/Reshape_1'^gradients/output_grad/tuple/group_deps*
_output_shapes
:*
T0*2
_class(
&$loc:@gradients/output_grad/Reshape_1
�
gradients/MatMul_grad/MatMulMatMul.gradients/output_grad/tuple/control_dependencyVariable/read*
T0*
transpose_a( *'
_output_shapes
:���������*
transpose_b(
�
gradients/MatMul_grad/MatMul_1MatMull2_normalize.gradients/output_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(*
_output_shapes

:
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
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
_output_shapes

:*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1
b
GradientDescent/learning_rateConst*
valueB
 *���>*
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
Variable_1GradientDescent/learning_rate0gradients/output_grad/tuple/control_dependency_1*
T0*
_class
loc:@Variable_1*
_output_shapes
:*
use_locking( 
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
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B 
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
_output_shapes

::*
dtypes
2
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
Variable_1save/RestoreV2:1*
use_locking(*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:
6
save/restore_allNoOp^save/Assign^save/Assign_1""
train_op

GradientDescent"�
	variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08"
	summaries

train_loss:0"�
trainable_variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08
���       ��2	N�|O�A*


train_lossg	D��~�        )��P	:y�|O�A*


train_loss�0�BE��        )��P	E��|O�A*


train_lossn�B<���        )��P	v��|O�A*


train_lossF �B�+&C        )��P	���|O�A*


train_loss1 �B��.�        )��P	%��|O�A*


train_loss��B\�:�        )��P	Z��|O�A*


train_loss�>�B��H6        )��P	ǟ�|O�A*


train_lossk��B�V�        )��P	r��|O�A*


train_loss9�BDK��        )��P	��|O�A	*


train_loss���B即�        )��P	���|O�A
*


train_lossKH�B�*Rc        )��P	=��|O�A*


train_loss7�Bv_�        )��P	���|O�A*


train_lossm�B��
�        )��P	���|O�A*


train_loss$�B����        )��P	���|O�A*


train_loss��BmJU        )��P	0��|O�A*


train_loss��B����        )��P	���|O�A*


train_loss�-�B�N��        )��P	H��|O�A*


train_lossh�B�[*�        )��P	���|O�A*


train_loss���B��
�        )��P	���|O�A*


train_loss@�BѦ:        )��P	^��|O�A*


train_loss�i�BGi�0        )��P	L��|O�A*


train_loss�׆B�(N        )��P	6�|O�A*


train_lossQP�B��'        )��P	��|O�A*


train_loss�҅Bݚ&8        )��P	��|O�A*


train_loss�]�B�
�        )��P	+�|O�A*


train_loss�B� �o        )��P	��|O�A*


train_loss%��B�i8�        )��P	�%�|O�A*


train_lossG.�BVb        )��P	Q,�|O�A*


train_loss�փB��?        )��P	�3�|O�A*


train_loss���B�{q        )��P	�9�|O�A*


train_loss�9�B�¤e        )��P	�?�|O�A*


train_loss3�B���        )��P	$F�|O�A *


train_lossQ��B"d        )��P	M�|O�A!*


train_loss�s�B�j�        )��P	�S�|O�A"*


train_loss]:�B��^q        )��P	BZ�|O�A#*


train_loss��Bpl�A        )��P	�`�|O�A$*


train_lossgҁB�Mm        )��P	�f�|O�A%*


train_lossY��BVҳ$        )��P	]m�|O�A&*


train_loss=w�B&kx�        )��P	�s�|O�A'*


train_loss�M�B�p�        )��P	�y�|O�A(*


train_loss�&�B��Z�        )��P	��|O�A)*


train_lossv�B0���        )��P	w��|O�A**


train_loss��B���        )��P	�|O�A+*


train_loss���B�G�        )��P	���|O�A,*


train_loss��BdquH        )��P	5��|O�A-*


train_lossC��B�
�        )��P	���|O�A.*


train_loss�h�Bh���        )��P	��|O�A/*


train_loss!O�Bz��1        )��P	��|O�A0*


train_loss�6�B�w        )��P	ĵ�|O�A1*


train_lossa�B?(v�        )��P	���|O�A2*


train_lossF	�B(ns�        )��P	���|O�A3*


train_lossr�B��x        )��P	��|O�A4*


train_lossS�B5K�        )��P	p��|O�A5*


train_loss�Bp��G        )��P	8��|O�A6*


train_loss`uBP͟        )��P	���|O�A7*


train_lossORB[���        )��P	���|O�A8*


train_loss�0BԮܩ        )��P	��|O�A9*


train_loss]B$l6�        )��P	���|O�A:*


train_lossM�~B%�ML        )��P	+��|O�A;*


train_loss_�~BL���        )��P	���|O�A<*


train_loss��~Bg���        )��P	!�|O�A=*


train_loss��~B\�Yv        )��P	��|O�A>*


train_loss�~B�<��        )��P	��|O�A?*


train_loss�e~B��Q�        )��P	T�|O�A@*


train_loss)L~B�A        )��P	��|O�AA*


train_loss�3~B?"��        )��P	�&�|O�AB*


train_loss�~B|t��        )��P	
.�|O�AC*


train_lossA~B����        )��P	5�|O�AD*


train_loss��}B�֜�        )��P	�<�|O�AE*


train_lossL�}B�F�        )��P	EG�|O�AF*


train_loss��}B��c        )��P	vO�|O�AG*


train_lossY�}B,�00        )��P	>Y�|O�AH*


train_loss��}B,�P        )��P	�c�|O�AI*


train_loss"�}Bd&��        )��P	vo�|O�AJ*


train_losso}B���        )��P	%y�|O�AK*


train_lossq[}B6�"�        )��P	���|O�AL*


train_lossH}B���        )��P	���|O�AM*


train_loss	5}BM/�o        )��P	���|O�AN*


train_lossI"}Bt))�        )��P	g��|O�AO*


train_loss�}B��        )��P	߫�|O�AP*


train_loss��|Bv^�        )��P	��|O�AQ*


train_loss��|BJ[�        )��P	T��|O�AR*


train_loss��|By��;        )��P	X��|O�AS*


train_loss#�|B��d        )��P	
��|O�AT*


train_loss��|BL�ĕ        )��P	v��|O�AU*


train_loss��|B�6�        )��P	-��|O�AV*


train_loss{�|BE6�F        )��P	j��|O�AW*


train_loss��|BY�S        )��P	�|O�AX*


train_loss�r|B��wD        )��P	��|O�AY*


train_lossGb|B���        )��P	Y�|O�AZ*


train_loss�Q|B��F        )��P	r�|O�A[*


train_loss~A|B^Elb        )��P	#�|O�A\*


train_lossK1|B7���        )��P	�)�|O�A]*


train_loss3!|B�v��        )��P	�0�|O�A^*


train_loss4|B���g        )��P	�7�|O�A_*


train_lossR|B�k7        )��P	>�|O�A`*


train_loss��{B�~H�        )��P	FD�|O�Aa*


train_loss��{BW���        )��P	�J�|O�Ab*


train_lossA�{B�Lu�        )��P	"R�|O�Ac*


train_loss��{BG� �        )��P	uX�|O�Ad*


train_lossO�{BݺLa        )��P	x.��|O�Ae*


train_loss��{B ���        )��P	8��|O�Af*


train_loss��{B�CX�        )��P	N@��|O�Ag*


train_loss{�{B���        )��P	@I��|O�Ah*


train_lossYv{B�(ȡ        )��P	�Q��|O�Ai*


train_lossIg{B�<c�        )��P	�Y��|O�Aj*


train_lossLX{B6�D        )��P	�c��|O�Ak*


train_lossYI{B� ˯        )��P	jl��|O�Al*


train_loss{:{BZ�~        )��P	�t��|O�Am*


train_loss�+{B�]DT        )��P	J}��|O�An*


train_loss�{B���m        )��P	Y���|O�Ao*


train_loss7{B�)-        )��P	d���|O�Ap*


train_loss��zB?)�W        )��P	J���|O�Aq*


train_loss��zB�U��        )��P	M���|O�Ar*


train_lossq�zB�/�$        )��P	����|O�As*


train_loss��zB��0}        )��P	���|O�At*


train_loss��zBy�x        )��P	ܻ��|O�Au*


train_loss �zBpLr|        )��P		���|O�Av*


train_lossǨzB�st'        )��P	����|O�Aw*


train_loss�zB�c�        )��P	l���|O�Ax*


train_loss@�zBM��        )��P	@���|O�Ay*


train_loss~zB��4�        )��P	���|O�Az*


train_loss�ozBPǑ        )��P	����|O�A{*


train_loss�azB���        )��P	����|O�A|*


train_loss�SzBӄB�        )��P	#���|O�A}*


train_loss�EzB��{�        )��P	���|O�A~*


train_loss�7zB���        )��P	���|O�A*


train_loss�)zB����!       {��	 ��|O�A�*


train_loss�zB�}��!       {��	���|O�A�*


train_losszB6�w!       {��	/��|O�A�*


train_loss5 zB�>�Q!       {��	%��|O�A�*


train_lossm�yB�Qt�!       {��	�%��|O�A�*


train_loss��yB<��!       {��	�,��|O�A�*


train_loss��yB4�}!       {��	i3��|O�A�*


train_lossU�yB؊h�!       {��	!:��|O�A�*


train_loss��yBQ�7!       {��	�@��|O�A�*


train_loss �yB4�Á!       {��	9G��|O�A�*


train_loss��yBL��!       {��	+M��|O�A�*


train_loss�yB ��E!       {��	�S��|O�A�*


train_loss��yBJ�&!       {��	Z��|O�A�*


train_loss*xyB8ܥd!       {��	J`��|O�A�*


train_loss�jyB���!       {��	f��|O�A�*


train_lossi]yB�Yv�!       {��	�l��|O�A�*


train_lossPyB�u��!       {��	s��|O�A�*


train_loss�ByB���!       {��	-y��|O�A�*


train_loss�5yB���!       {��	���|O�A�*


train_lossU(yB(	W!       {��	8���|O�A�*


train_loss'yB��w�!       {��	Ό��|O�A�*


train_lossyB�m7O!       {��	���|O�A�*


train_loss� yBuw�!       {��	���|O�A�*


train_loss��xBnUL!       {��	����|O�A�*


train_loss��xB�V��!       {��	G���|O�A�*


train_loss��xBq�i�!       {��	���|O�A�*


train_loss��xBsT-!       {��	����|O�A�*


train_loss�xB"�6
!       {��	8���|O�A�*


train_loss��xB�R�%!       {��	���|O�A�*


train_loss�xB���!       {��	d���|O�A�*


train_lossC�xB����!       {��	����|O�A�*


train_losst�xB����!       {��	����|O�A�*


train_loss�xB�{Y�!       {��	����|O�A�*


train_loss�rxB�5Ū!       {��	'���|O�A�*


train_loss@fxB��!       {��	���|O�A�*


train_loss�YxB.��{!       {��	���|O�A�*


train_loss�LxBH�Ӳ!       {��	 ���|O�A�*


train_lossU@xB��!       {��	����|O�A�*


train_loss�3xB,�n1!       {��	*���|O�A�*


train_loss<'xB��!       {��	q��|O�A�*


train_loss�xBo���!       {��	|	��|O�A�*


train_lossAxB.<�[!       {��	���|O�A�*


train_loss�xB'n�!       {��	���|O�A�*


train_losse�wB��O�!       {��	r��|O�A�*


train_loss�wB�w�h!       {��	d!��|O�A�*


train_loss��wBɣl!       {��	N'��|O�A�*


train_lossX�wBD�Ǵ!       {��	-��|O�A�*


train_loss�wB.�i!       {��	33��|O�A�*


train_lossзwB�Բ!       {��	C9��|O�A�*


train_loss��wB,�O�!       {��	$?��|O�A�*


train_lossf�wB� ��!       {��	E��|O�A�*


train_loss>�wB���!       {��	�J��|O�A�*


train_loss�wB��!       {��	�P��|O�A�*


train_loss{wB"�VF!       {��	�W��|O�A�*


train_loss�nwB��~!       {��	�]��|O�A�*


train_loss�bwB�=!!       {��	�d��|O�A�*


train_loss�VwBd��}!       {��	�k��|O�A�*


train_loss�JwB�}�!       {��	�q��|O�A�*


train_loss�>wB�X�!       {��	�w��|O�A�*


train_loss3wB���!       {��	�}��|O�A�*


train_loss-'wB��)�!       {��	f���|O�A�*


train_lossQwB4���!       {��	Ҋ��|O�A�*


train_loss}wBm��:!       {��	O���|O�A�*


train_loss�wB�
�!       {��	����|O�A�*


train_loss��vB��69!       {��	f���|O�A�*


train_loss0�vB���q!       {��	a���|O�A�*


train_lossy�vB��T!       {��	K���|O�A�*


train_loss��vB�@�!       {��	l���|O�A�*


train_loss$�vB.l��!       {��	̶��|O�A�*


train_loss��vB_7�!       {��	���|O�A�*


train_loss�vB�2�/!       {��	����|O�A�*


train_loss_�vB�\;W!       {��	y���|O�A�*


train_lossԚvB��M�!       {��	p���|O�A�*


train_lossT�vBY���!       {��	\y��|O�A�*


train_lossكvB?j�[!       {��	����|O�A�*


train_lossfxvB�<Y3!       {��	����|O�A�*


train_loss�lvB��=!       {��	���|O�A�*


train_loss�avBa'%!       {��	���|O�A�*


train_loss7VvB��!       {��	`���|O�A�*


train_loss�JvB?�k!       {��	���|O�A�*


train_loss�?vB�b�!       {��	 ���|O�A�*


train_lossI4vB6
��!       {��	���|O�A�*


train_loss	)vB�qx!       {��	���|O�A�*


train_loss�vB|y�!       {��	����|O�A�*


train_loss�vB��|;!       {��	����|O�A�*


train_lossovB>jŰ!       {��	����|O�A�*


train_lossK�uBz&!       {��	%���|O�A�*


train_loss-�uBS�!       {��	+���|O�A�*


train_loss�uBz"�!       {��	8���|O�A�*


train_loss�uB�2U!       {��	&���|O�A�*


train_loss��uB�>ϛ!       {��	T��|O�A�*


train_loss��uB7`�z!       {��	k��|O�A�*


train_loss��uBB�T!       {��	M��|O�A�*


train_loss
�uBʗHA!       {��	���|O�A�*


train_loss�uB�t/q!       {��	� ��|O�A�*


train_loss6�uB?a��!       {��	h'��|O�A�*


train_lossT�uB�I!       {��	.��|O�A�*


train_loss{�uB��q!       {��	�4��|O�A�*


train_loss�xuB�3�!       {��	;��|O�A�*


train_loss�muB�A�!       {��	�A��|O�A�*


train_losscuBy[.�!       {��	H��|O�A�*


train_lossUXuBjtV:!       {��	N��|O�A�*


train_loss�MuBA��!       {��	&U��|O�A�*


train_loss�BuB�5�!       {��	![��|O�A�*


train_lossC8uB�~�!       {��	�`��|O�A�*


train_loss�-uB��W!       {��	#g��|O�A�*


train_loss�"uB���!       {��	{m��|O�A�*


train_lossfuB���!       {��	�s��|O�A�*


train_loss�uB3���!       {��	6z��|O�A�*


train_lossKuB��!       {��	����|O�A�*


train_loss��tBZL��!       {��	���|O�A�*


train_lossG�tB<MuM!       {��	L���|O�A�*


train_loss��tB!��!       {��	���|O�A�*


train_loss]�tB�BN�!       {��	����|O�A�*


train_loss��tB%�ʻ!       {��	����|O�A�*


train_loss��tB߀�!       {��	H���|O�A�*


train_loss0�tB����!       {��	����|O�A�*


train_lossٯtBL�T.!       {��	����|O�A�*


train_loss��tBDb�!       {��	����|O�A�*


train_loss<�tB��k4!       {��	���|O�A�*


train_loss��tB���"!       {��	����|O�A�*


train_loss��tB}#+`!       {��	����|O�A�*


train_loss||tB����!       {��	����|O�A�*


train_lossLrtB����!       {��	����|O�A�*


train_losshtBo9#!       {��	����|O�A�*


train_loss�]tB�H]!       {��	����|O�A�*


train_loss�StBOi�!       {��	����|O�A�*


train_loss�ItBi�>!       {��	����|O�A�*


train_loss�?tBҺ�V!       {��	����|O�A�*


train_loss�5tBՙ�!       {��	.���|O�A�*


train_loss�+tBH{F!       {��	!��|O�A�*


train_loss�!tB�Z!       {��	���|O�A�*


train_loss�tB?|\�!       {��	���|O�A�*


train_loss�tB}�!       {��	���|O�A�*


train_loss�tB�fzY!       {��	���|O�A�*


train_loss��sB�p��!       {��	� ��|O�A�*


train_loss��sBt�!�!       {��	 '��|O�A�*


train_loss��sB��i�!       {��	c-��|O�A�*


train_loss"�sB-�q|!       {��	]3��|O�A�*


train_lossN�sB����!       {��	y9��|O�A�*


train_loss��sB��!       {��	`?��|O�A�*


train_loss��sB�w�u!       {��	JE��|O�A�*


train_loss��sB��2+!       {��	�K��|O�A�*


train_loss:�sB���!       {��	�Q��|O�A�*


train_loss��sBm��Q!       {��	�W��|O�A�*


train_lossЗsB�,�!       {��	�]��|O�A�*


train_loss&�sB�!       {��	�c��|O�A�*


train_loss�sB�ͮ!       {��	�i��|O�A�*


train_loss�zsB�J�!       {��	�o��|O�A�*


train_lossDqsBը�!       {��	�u��|O�A�*


train_loss�gsB.�ԓ!       {��	�{��|O�A�*


train_loss^sB���J!       {��	���|O�A�*


train_loss�TsB?�f7!       {��	/���|O�A�*


train_lossKsB��A�!       {��	d���|O�A�*


train_loss�AsBf�.!       {��	���|O�A�*


train_loss8sB�;Y�!       {��	���|O�A�*


train_loss�.sB�ݻ�!       {��	z���|O�A�*


train_loss9%sBw��!       {��	����|O�A�*


train_loss�sB,4��!       {��	���|O�A�*


train_lossjsB��!       {��	k���|O�A�*


train_loss	sB.F�!       {��	V���|O�A�*


train_loss��rB/�1�!       {��	*���|O�A�*


train_lossa�rB :/!       {��	y���|O�A�*


train_loss�rB�g�f!       {��	����|O�A�*


train_loss��rB<f�Z!       {��	����|O�A�*


train_loss��rB�FO�!       {��	@���|O�A�*


train_lossJ�rB+7?!       {��	n���|O�A�*


train_loss�rB�! !       {��	����|O�A�*


train_loss۾rBJ�@B!       {��	����|O�A�*


train_loss��rB
��!       {��	����|O�A�*


train_loss��rBm+�!       {��	���|O�A�*


train_loss_�rB���!       {��	� ��|O�A�*


train_lossB�rB=pO�!       {��	���|O�A�*


train_loss'�rB���!       {��	?���|O�A�*


train_loss�rB�<GW!       {��	4���|O�A�*


train_lossrB<p��!       {��	U���|O�A�*


train_loss�urB	���!       {��	����|O�A�*


train_loss�lrBqDC!       {��	a���|O�A�*


train_loss�crBT���!       {��	u��|O�A�*


train_loss�ZrB����!       {��	���|O�A�*


train_lossRrBR*��!       {��	 ��|O�A�*


train_lossIrBH�!       {��	�$��|O�A�*


train_loss%@rB^��S!       {��	�.��|O�A�*


train_loss?7rB ��s!       {��	�8��|O�A�*


train_loss].rB���#!       {��	C��|O�A�*


train_loss%rBʈ��!       {��	M��|O�A�*


train_loss�rB2I0!       {��	mW��|O�A�*


train_loss�rB�5�!       {��	ga��|O�A�*


train_lossrBM(�!       {��	�j��|O�A�*


train_loss=rB)O�N!       {��	�q��|O�A�*


train_lossv�qB�Q`!       {��	�z��|O�A�*


train_loss��qB��P!       {��	{���|O�A�*


train_loss��qB��6!       {��	F���|O�A�*


train_lossI�qB�֚�!       {��	����|O�A�*


train_loss��qB~ӑ�!       {��	D���|O�A�*


train_loss��qB��o!       {��	����|O�A�*


train_lossC�qB�]0�!       {��	����|O�A�*


train_loss��qB�n�!       {��	����|O�A�*


train_loss�qB�&a!       {��	����|O�A�*


train_lossi�qB�?rF!       {��	����|O�A�*


train_lossӢqBc��O!       {��	2���|O�A�*


train_lossC�qB¾��!       {��	l���|O�A�*


train_loss��qB�&B+!       {��	A���|O�A�*


train_loss2�qB'���!       {��	� ��|O�A�*


train_loss��qB�w��!       {��	���|O�A�*


train_loss3xqB�
M!       {��	r��|O�A�*


train_loss�oqB�ǣ�!       {��	��|O�A�*


train_lossCgqB���}!       {��	�$��|O�A�*


train_loss�^qBy(�!       {��	�/��|O�A�*


train_lossiVqB�蝟!       {��	~:��|O�A�*


train_lossNqB�^��!       {��	C��|O�A�*


train_loss�EqB��!       {��	�L��|O�A�*


train_lossC=qB�x�O!       {��	GT��|O�A�*


train_loss�4qBiS�!       {��	�[��|O�A�*


train_loss�,qB�3�!       {��	{c��|O�A�*


train_lossE$qB-�i�!       {��		k��|O�A�*


train_loss�qB�k��!       {��	�r��|O�A�*


train_loss�qB�� !       {��	�y��|O�A�*


train_losspqB��r!       {��	E���|O�A�*


train_loss3qB2m��!       {��	����|O�A�*


train_loss��pB����!       {��	���|O�A�*


train_loss��pB�q�m!       {��	ė��|O�A�*


train_loss��pB(���!       {��	����|O�A�*


train_lossd�pB7�K]!       {��	Y���|O�A�*


train_loss;�pBZ4��!       {��	z���|O�A�*


train_loss�pB�i��!       {��	F���|O�A�*


train_loss��pB�<�!       {��	s���|O�A�*


train_loss��pB�уB!       {��	����|O�A�*


train_lossĹpB�Ҁ�!       {��	:���|O�A�*


train_loss��pBaZ�M!       {��	����|O�A�*


train_loss��pB�
kz!       {��	����|O�A�*


train_loss��pB��Ύ!       {��	.���|O�A�*


train_loss��pB"~��!       {��	����|O�A�*


train_loss��pBX^\!       {��	����|O�A�*


train_loss��pB�@��!       {��	����|O�A�*


train_loss��pBO�B�!       {��	����|O�A�*


train_loss�ypB�w�!       {��	���|O�A�*


train_loss�qpB~��7!       {��	���|O�A�*


train_loss�ipB��!       {��	]��|O�A�*


train_loss�apBsP�!       {��	�"��|O�A�*


train_loss�YpB45ަ!       {��	�*��|O�A�*


train_lossRpBh:��!       {��	�2��|O�A�*


train_loss8JpBn�K!       {��	a9��|O�A�*


train_loss_BpB����!       {��	2@��|O�A�*


train_loss�:pB���g!       {��	�F��|O�A�*


train_loss�2pB^�!       {��	M��|O�A�*


train_loss�*pB�/�!       {��	TT��|O�A�*


train_loss##pB���!       {��	yZ��|O�A�*


train_loss]pB�cW�!       {��	k`��|O�A�*


train_loss�pBm�S�!       {��	f��|O�A�*


train_loss�pBx�E!       {��	zm��|O�A�*


train_loss(pBRF:d!       {��	�s��|O�A�*


train_losss�oB>I!       {��	�y��|O�A�*


train_loss��oB�|[�!       {��	����|O�A�*


train_loss�oBXas!       {��	����|O�A�*


train_lossi�oBq��!       {��	ڍ��|O�A�*


train_loss��oB��w!       {��	���|O�A�*


train_loss%�oB5^ !       {��	ՙ��|O�A�*


train_loss��oB/,�!       {��	ן��|O�A�*


train_loss��oBo�F!       {��	f���|O�A�*


train_lossV�oBWv!       {��	���|O�A�*


train_lossŷoBH��!       {��	W���|O�A�*


train_loss7�oB�
/!       {��	V���|O�A�*


train_loss��oB�O��!       {��		���|O�A�*


train_loss%�oB�V!       {��	����|O�A�*


train_loss��oB�*b!       {��	����|O�A�*


train_loss$�oBm��:!       {��	����|O�A�*


train_loss��oB��!       {��	���|O�A�*


train_loss3�oBK��!       {��	;���|O�A�*


train_loss�{oB��1!       {��	F���|O�A�*


train_lossOtoB"�i�!       {��	}���|O�A�*


train_loss�loB�\l!       {��	o���|O�A�*


train_lossweoBb2��!       {��	���|O�A�*


train_loss^oB-��!       {��	�� �|O�A�*


train_loss�VoBP6�G!       {��	�� �|O�A�*


train_lossUOoB��n!       {��	�� �|O�A�*


train_loss�GoB�W��!       {��	�� �|O�A�*


train_loss�@oB?�!       {��	�� �|O�A�*


train_lossQ9oB�ጜ!       {��	�� �|O�A�*


train_loss2oB�J &!       {��	�� �|O�A�*


train_loss�*oBEQ�!       {��	�� �|O�A�*


train_losso#oB���!       {��	�� �|O�A�*


train_loss)oB�M�!       {��	� �|O�A�*


train_loss�oB�ȿ�!       {��	[� �|O�A�*


train_loss�oB�S-!       {��	�� �|O�A�*


train_losspoBb���!       {��	m� �|O�A�*


train_loss<�nB�O!       {��	��|O�A�*


train_loss�nB^�p!       {��	�|O�A�*


train_loss��nB��A!       {��	��|O�A�*


train_loss��nB	'�!       {��	P�|O�A�*


train_loss��nB�=��!       {��	% �|O�A�*


train_loss_�nB���!       {��	$'�|O�A�*


train_loss?�nB]!vo!       {��	�-�|O�A�*


train_loss�nB�!       {��	�4�|O�A�*


train_loss�nB, ��!       {��	�;�|O�A�*


train_loss�nB�}�!       {��	�E�|O�A�*


train_loss۷nB�>k�!       {��	�O�|O�A�*


train_lossȰnB�]�!       {��	�W�|O�A�*


train_loss��nB�e� !       {��	�b�|O�A�*


train_loss��nBi0P!       {��	�l�|O�A�*


train_loss��nB���!       {��	Rz�|O�A�*


train_loss��nB���Q!       {��	I��|O�A�*


train_loss��nB6�!       {��	ƌ�|O�A�*


train_loss��nB���!       {��	B��|O�A�*


train_loss�nB
��B!       {��	a��|O�A�*


train_loss�xnB��r<!       {��	��|O�A�*


train_loss�qnB�8�!       {��	��|O�A�*


train_loss�jnB�{)!       {��	���|O�A�*


train_loss�cnB$
��!       {��	���|O�A�*


train_loss]nB�1��!       {��	9��|O�A�*


train_loss"VnB� �!       {��	��|O�A�*


train_loss@OnB�u��!       {��	���|O�A�*


train_losscHnB�3�!       {��	���|O�A�*


train_loss�AnBJe��!       {��	���|O�A�*


train_loss�:nB����!       {��	��|O�A�*


train_loss�3nB7&B�!       {��	�|O�A�*


train_loss-nB����!       {��	�%�|O�A�*


train_loss8&nB�H�$!       {��	�/�|O�A�*


train_lossknB���U!       {��	�9�|O�A�*


train_loss�nBH��!       {��	�C�|O�A�*


train_loss�nB�I�z!       {��	jM�|O�A�*


train_lossnBq*��!       {��	~U�|O�A�*


train_loss[nB$نu!       {��	�\�|O�A�*


train_loss��mB�p��!       {��	5c�|O�A�*


train_loss��mB��i!       {��	l�|O�A�*


train_loss1�mB� �k!       {��	�s�|O�A�*


train_loss}�mBb�6!       {��	){�|O�A�*


train_loss��mB^?�G!       {��	���|O�A�*


train_loss!�mB%�!       {��	֋�|O�A�*


train_lossw�mB�C�i!       {��	y��|O�A�*


train_loss��mB_�C�!       {��	���|O�A�*


train_loss/�mB�c��!       {��	�|O�A�*


train_loss��mB,��!       {��	��|O�A�*


train_loss�mB�_!       {��	��|O�A�*


train_lossU�mBرX�!       {��	��|O�A�*


train_loss��mB�"#�!       {��	|��|O�A�*


train_loss(�mB��2!       {��	��|O�A�*


train_loss��mB1�!       {��	���|O�A�*


train_loss	�mB�b��!       {��	���|O�A�*


train_loss�mB^[!       {��	Z��|O�A�*


train_loss��mB�qjo!       {��	��|O�A�*


train_lossn�mB�H!       {��	���|O�A�*


train_loss�mB���j!       {��	���|O�A�*


train_losslymB�̋~!       {��	N��|O�A�*


train_loss�rmBO�K!       {��	���|O�A�*


train_lossvlmBI׋!       {��	'��|O�A�*


train_loss�emB�&	~!       {��	��|O�A�*


train_loss�_mB��؟!       {��	)	�|O�A�*


train_lossYmB�	�!       {��	b�|O�A�*


train_loss�RmBy���!       {��	��|O�A�*


train_loss>LmB�R޾!       {��	��|O�A�*


train_loss�EmB!Q�-!       {��	[&�|O�A�*


train_lossn?mBG�D&!       {��	�.�|O�A�*


train_loss9mB��=!       {��	�5�|O�A�*


train_loss�2mB�M��!       {��	6<�|O�A�*


train_lossO,mB��!       {��	C�|O�A�*


train_loss�%mB�7ט!       {��	�I�|O�A�*


train_loss�mB�)��!       {��	QO�|O�A�*


train_lossEmB��Ͳ!       {��	�U�|O�A�*


train_loss�mB�v�5!       {��	 \�|O�A�*


train_loss�mB<�h�!       {��	sb�|O�A�*


train_lossTmB����!       {��	�h�|O�A�*


train_loss
 mB���!       {��	\o�|O�A�*


train_loss��lBĭ�J!       {��	�u�|O�A�*


train_loss|�lB{�Y!       {��	R|�|O�A�*


train_loss;�lB�5#W!       {��	ƃ�|O�A�*


train_loss��lB!�
!       {��	��|O�A�*


train_loss��lB��2�!       {��	��|O�A�*


train_loss��lB�=�0!       {��	W��|O�A�*


train_lossM�lB���!       {��	g��|O�A�*


train_loss�lB���!       {��	���|O�A�*


train_loss��lB��S!       {��	���|O�A�*


train_loss��lB���)!       {��	��|O�A�*


train_loss��lB��~�!       {��	�W�|O�A�*


train_lossa�lB���!       {��	B^�|O�A�*


train_loss:�lB�{!       {��	�e�|O�A�*


train_loss�lBÆp!       {��	�o�|O�A�*


train_loss�lB��!       {��	-x�|O�A�*


train_lossҜlB�n�!       {��	k~�|O�A�*


train_loss��lB��1>!       {��	��|O�A�*


train_loss��lB{8��!       {��	��|O�A�*


train_loss��lBG�(�!       {��	���|O�A�*


train_losso�lB|�>!       {��	c��|O�A�*


train_loss[~lB�RI�!       {��	4��|O�A�*


train_lossKxlB�W�h!       {��	���|O�A�*


train_loss=rlBB1�(!       {��	���|O�A�*


train_loss2llBȈ��!       {��	l��|O�A�*


train_loss)flB�.�!       {��	'��|O�A�*


train_loss"`lB���`!       {��	���|O�A�*


train_lossZlB�U�!       {��	���|O�A�*


train_lossTlBWA� !       {��	���|O�A�*


train_lossNlB�u�H!       {��	���|O�A�*


train_loss HlB�p6!       {��	���|O�A�*


train_loss(BlBӉ�!       {��	���|O�A�*


train_loss1<lB�My!       {��	?��|O�A�*


train_loss=6lBu<!�!       {��	��|O�A�*


train_lossK0lB�$�H!       {��	��|O�A�*


train_loss\*lBޖ�!       {��	���|O�A�*


train_lossm$lB�9L�!       {��	���|O�A�*


train_loss�lB�b.�!       {��	\�|O�A�*


train_loss�lB{C'�!       {��	�
�|O�A�*


train_loss�lB =�W!       {��	�|O�A�*


train_loss�lB��$!       {��	��|O�A�*


train_loss�lB�Q1�!       {��	?�|O�A�*


train_losslB��O!       {��	&�|O�A�*


train_loss3�kB�~��!       {��	{,�|O�A�*


train_lossY�kBqbv!       {��	v2�|O�A�*


train_loss��kB���!       {��	X8�|O�A�*


train_loss��kBxp�v!       {��	 >�|O�A�*


train_loss��kBBG�!       {��	D�|O�A�*


train_loss�kB�'��!       {��	J�|O�A�*


train_loss:�kB3�B�!       {��	YP�|O�A�*


train_lossn�kBdR!       {��	~V�|O�A�*


train_loss��kBD�H;!       {��	S\�|O�A�*


train_loss��kB�\��!       {��	Nb�|O�A�*


train_loss�kB�3ڏ!       {��	�h�|O�A�*


train_lossT�kB��x!       {��	{n�|O�A�*


train_loss��kB�>q�!       {��	}t�|O�A�*


train_lossׯkBdW�8!       {��	tz�|O�A�*


train_loss�kB��!       {��	Ѐ�|O�A�*


train_loss_�kBz�S(!       {��	���|O�A�*


train_loss��kB0ǊG!       {��	���|O�A�*


train_loss�kB�<q!       {��	���|O�A�*


train_loss@�kB�F,!       {��	���|O�A�*


train_loss��kB �+�!       {��	���|O�A�*


train_loss�kB�G1u!       {��	T��|O�A�*


train_loss3�kB����!       {��	7��|O�A�*


train_loss�|kB��!       {��	`��|O�A�*


train_loss�vkB�#�!       {��	S��|O�A�*


train_loss=qkBT�:!       {��	U��|O�A�*


train_loss�kkB�JD�!       {��	Q��|O�A�*


train_loss�ekB>�v!       {��	d��|O�A�*


train_lossX`kB��IF!       {��	N��|O�A�*


train_loss�ZkB�U�7!       {��	N��|O�A�*


train_loss"UkB�Cz�!       {��	���|O�A�*


train_loss�OkB� F9!       {��	���|O�A�*


train_loss�IkB���@!       {��	���|O�A�*


train_lossaDkB1f�!       {��	��|O�A�*


train_loss�>kB�@`!       {��	o��|O�A�*


train_loss<9kBӺ(!       {��	���|O�A�*


train_loss�3kB;��!       {��	m��|O�A�*


train_loss".kB�׳�!       {��	��|O�A�*


train_loss�(kB�41�!       {��	��|O�A�*


train_loss#kB�n�!       {��	��|O�A�*


train_loss�kB	��!       {��	��|O�A�*


train_loss
kB[�8v!       {��	��|O�A�*


train_loss�kB�}x!       {��	�#�|O�A�*


train_loss	kBek�_!       {��	|)�|O�A�*


train_loss�kBČP<!       {��	�/�|O�A�*


train_losskB��s�!       {��	�5�|O�A�*


train_loss��jBFhq!       {��	�A�|O�A�*


train_loss!�jB�nfa!       {��	+I�|O�A�*


train_loss��jB�KY!       {��	�O�|O�A�*


train_loss<�jBLu�3!       {��	�V�|O�A�*


train_loss��jBz���!       {��	O]�|O�A�*


train_loss\�jB"O5O!       {��	�c�|O�A�*


train_loss��jB"\N!       {��	�i�|O�A�*


train_loss��jB��:�!       {��	p�|O�A�*


train_loss�jBkjl�!       {��	yv�|O�A�*


train_loss��jB�7�!       {��	p�|O�A�*


train_lossR�jB�IA!       {��	Ӆ�|O�A�*


train_loss��jB���!       {��	C��|O�A�*


train_loss��jB7g�p!       {��	>��|O�A�*


train_loss0�jB�ȹ!       {��	��|O�A�*


train_loss԰jB��T�!       {��	��|O�A�*


train_loss{�jB���!       {��	���|O�A�*


train_loss�jB �Z(!       {��	&��|O�A�*


train_lossʠjB����!       {��	6��|O�A�*


train_lossu�jB e1�!       {��	k��|O�A�*


train_loss$�jB��C�!       {��	���|O�A�*


train_lossӐjB��8!       {��	z��|O�A�*


train_loss��jB�U�g!       {��	7��|O�A�*


train_loss6�jB���!       {��	���|O�A�*


train_loss�jB��,!       {��	I��|O�A�*


train_loss�{jBE�!       {��	��|O�A�*


train_loss]vjB���P!       {��	F��|O�A�*


train_lossqjBq��!       {��	ʡ�|O�A�*


train_loss�kjB����!       {��	���|O�A�*


train_loss�fjB�Ks!       {��	���|O�A�*


train_lossQajB|3�C!       {��	��|O�A�*


train_loss\jBV�2!       {��	��|O�A�*


train_loss�VjBD,�!       {��	���|O�A�*


train_loss�QjB��&!       {��	���|O�A�*


train_lossfLjB���!       {��	��|O�A�*


train_loss0GjB��{�!       {��	��|O�A�*


train_loss�AjBx%��!       {��	*��|O�A�*


train_loss�<jB�q�!       {��	���|O�A�*


train_loss�7jB��!       {��	
��|O�A�*


train_lossj2jB�p�!       {��	���|O�A�*


train_loss;-jB��c�!       {��	��|O�A�*


train_loss(jB���z!       {��	p	�|O�A�*


train_loss�"jBj��A!       {��	V�|O�A�*


train_loss�jB�~�!       {��	��|O�A�*


train_loss�jBH+��!       {��	S�|O�A�*


train_lossvjB���6!       {��	�#�|O�A�*


train_lossUjBt�HY!       {��	*�|O�A�*


train_loss5	jB�!��!       {��	�0�|O�A�*


train_lossjB����!       {��	&7�|O�A�*


train_loss��iB��t7!       {��	=�|O�A�*


train_loss��iBMǵ!       {��	=C�|O�A�*


train_loss��iBR	��!       {��	I�|O�A�*


train_loss��iB`.m#!       {��	O�|O�A�*


train_loss��iB��&�!       {��	�U�|O�A�*


train_loss��iB|�S!       {��	2\�|O�A�*


train_lossq�iBrNa	!       {��	bb�|O�A�*


train_loss_�iBu$�+!       {��	wh�|O�A�*


train_lossQ�iB���!       {��	�n�|O�A�*


train_lossE�iB��d=!       {��	�t�|O�A�*


train_loss7�iB�s�!       {��	�z�|O�A�*


train_loss/�iBiB �!       {��	��|O�A�*


train_loss(�iB2��!       {��	���|O�A�*


train_loss!�iB�j!       {��	���|O�A�*


train_loss�iB�o�!       {��	��|O�A�*


train_loss�iB[��Y!       {��	���|O�A�*


train_loss�iBF�>�!       {��	���|O�A�*


train_loss�iB-!Sp!       {��		��|O�A�*


train_loss�iB�Q�!       {��	i��|O�A�*


train_loss �iBV�|#!       {��	F��|O�A�*


train_loss%�iB9�k!       {��	R��|O�A�*


train_loss,�iB�wi~!       {��	+��|O�A�*


train_loss5�iBoIw>!       {��	U��|O�A�*


train_lossA�iB���!       {��	P��|O�A�*


train_lossL�iB�RO�!       {��	h��|O�A�*


train_loss[�iB�Y�!       {��	���|O�A�*


train_lossj|iB=�6�!       {��	���|O�A�*


train_loss}wiBL� !       {��	���|O�A�*


train_loss�riB���!       {��	��|O�A�*


train_loss�miB����!       {��	���|O�A�*


train_loss�hiBu��W!       {��	���|O�A�*


train_loss�ciBF��!       {��	���|O�A�*


train_loss�^iB��m!       {��	� 	�|O�A�*


train_lossZiB?�9�!       {��	�	�|O�A�*


train_loss"UiBI ]�!       {��		�|O�A�*


train_loss@PiB	��!       {��	�	�|O�A�*


train_loss_KiB�8>�!       {��	�	�|O�A�*


train_loss�FiB�2\�!       {��	�	�|O�A�*


train_loss�AiB�er`!       {��	 %	�|O�A�*


train_loss�<iB��!       {��	�*	�|O�A�*


train_loss�7iB��!       {��	�0	�|O�A�*


train_loss3iB[M+%!       {��	7	�|O�A�*


train_loss@.iB(~fR!       {��	�<	�|O�A�*


train_lossj)iBG��W!       {��	�B	�|O�A�*


train_loss�$iBL��!       {��	
I	�|O�A�*


train_loss�iB���!       {��	<O	�|O�A�*


train_loss�iB���@!       {��	U	�|O�A�*


train_loss%iBH���!       {��	�Z	�|O�A�*


train_lossWiB���-!       {��	�`	�|O�A�*


train_loss�iB��e�!       {��	^g	�|O�A�*


train_loss�iB�0�!       {��	Pm	�|O�A�*


train_loss�iBOQf
!       {��	�w	�|O�A�*


train_loss1�hBU?��!       {��	c	�|O�A�*


train_lossk�hB%��!       {��	��	�|O�A�*


train_loss��hB9NU1!       {��	z�	�|O�A�*


train_loss��hB'|�R!       {��	��	�|O�A�*


train_loss!�hBIe�!       {��	��	�|O�A�*


train_lossb�hBd�E�!       {��	��	�|O�A�*


train_loss��hB��?s!       {��	��	�|O�A�*


train_loss��hBV���!       {��	%�	�|O�A�*


train_loss.�hB2�u�!       {��	%�	�|O�A�*


train_lossr�hB[2Z�!       {��	A�	�|O�A�*


train_loss��hBkظ_!       {��	o�	�|O�A�*


train_loss�hB�/��!       {��	��	�|O�A�*


train_lossM�hB6?�!       {��	��	�|O�A�*


train_loss��hB���]!       {��	��	�|O�A�*


train_loss�hBx���!       {��	��	�|O�A�*


train_loss7�hB����!       {��	4�	�|O�A�*


train_loss��hB�e�!       {��	"�	�|O�A�*


train_lossڭhB^�S!       {��	h�	�|O�A�*


train_loss,�hBi (q!       {��	[�	�|O�A�*


train_loss�hBiÛ!       {��	8�	�|O�A�*


train_lossןhBT=�!       {��	�	�|O�A�*


train_loss/�hB��u�!       {��	� 
�|O�A�*


train_loss��hB$[�R!       {��	�
�|O�A�*


train_lossߑhBPo!       {��	��|O�A�*


train_loss>�hB�e��!       {��	��|O�A�*


train_loss��hB1=}�!       {��	O��|O�A�*


train_loss��hB'L!       {��	p��|O�A�*


train_lossYhB+;k!       {��	���|O�A�*


train_loss�zhB�(b�!       {��	���|O�A�*


train_lossvhB�&�|!       {��	_��|O�A�*


train_loss�qhBG4�!       {��	s��|O�A�*


train_loss�lhB@��!       {��	r��|O�A�*


train_lossLhhBb�/i!       {��	���|O�A�*


train_loss�chB$�>�!       {��	���|O�A�*


train_loss_hB��@!       {��	���|O�A�*


train_loss�ZhB���!       {��	���|O�A�*


train_loss�UhB%Nb!       {��	���|O�A�*


train_lossdQhB�j!       {��	L��|O�A�*


train_loss�LhB���{!       {��	���|O�A�*


train_lossEHhB;u�!       {��	���|O�A�*


train_loss�ChB�V�!       {��	#��|O�A�*


train_loss)?hB�[�!       {��	� �|O�A�*


train_loss�:hB�w�;!       {��	��|O�A�*


train_loss6hB���!       {��	3�|O�A�*


train_loss�1hB�SvV!       {��	�!�|O�A�*


train_loss-hB��du!       {��	A)�|O�A�*


train_loss~(hB��<�!       {��	@0�|O�A�*


train_loss�#hB�?{�!       {��	�7�|O�A�*


train_lossthBf��!       {��	�=�|O�A�*


train_loss�hB�%�!       {��	�D�|O�A�*


train_lossphB����!       {��	�K�|O�A�*


train_loss�hB���!       {��	zR�|O�A�*


train_lossrhB'��!       {��	>Y�|O�A�*


train_loss�hB3�L!       {��	�_�|O�A�*


train_losszhB�R�!       {��	4f�|O�A�*


train_loss hB>.�!       {��	�m�|O�A�*


train_loss��gB�KH!       {��	�t�|O�A�*


train_loss�gBl?Sk!       {��	�z�|O�A�*


train_loss��gB�}~�!       {��	Z��|O�A�*


train_loss!�gB���!       {��	ˇ�|O�A�*


train_loss��gB"��?!       {��	э�|O�A�*


train_loss=�gB|#?}!       {��	x��|O�A�*


train_loss��gB��m!       {��	Ԛ�|O�A�*


train_loss[�gB99�/!       {��	���|O�A�*


train_loss��gBh%'@!       {��	@��|O�A�*


train_loss~�gB>�"�!       {��	.��|O�A�*


train_loss�gBl�_!       {��	S��|O�A�*


train_loss��gBK�s�!       {��	���|O�A�*


train_loss=�gB��̳!       {��	��|O�A�*


train_loss��gB)���!       {��	7��|O�A�*


train_lossl�gBD(��!       {��	���|O�A�*


train_loss�gB��y!       {��	��|O�A�*


train_loss��gB�ȃ!       {��	8��|O�A�*


train_loss=�gBZ�I<!       {��	��|O�A�*


train_lossܫgBZ3y!       {��	!��|O�A�*


train_lossw�gBi�m�!       {��	O��|O�A�*


train_loss�gB]K�!       {��	���|O�A�*


train_loss��gB����!       {��	���|O�A�*


train_loss\�gB��^!       {��	���|O�A�*


train_loss��gB>�!       {��	:�|O�A�*


train_loss��gB��2!       {��	��|O�A�*


train_lossK�gB.n�P!       {��	@�|O�A�*


train_loss��gB��P!       {��	 �|O�A�*


train_loss��gBD8��!       {��	�*�|O�A�*


train_lossC�gB��5�!       {��	�3�|O�A�*


train_loss�{gB)�;�!       {��	�<�|O�A�*


train_loss�wgBvk!       {��	tE�|O�A�*


train_lossFsgBV,m2!       {��	P�|O�A�*


train_loss�ngB��p!       {��	O_�|O�A�*


train_loss�jgB43�!       {��	�l�|O�A�*


train_lossTfgB�x!       {��	�|�|O�A�*


train_lossbgB55(!       {��	���|O�A�*


train_loss�]gBZ+�!       {��	t��|O�A�*


train_losskYgBRl�'!       {��	���|O�A�*


train_loss!UgBj��!       {��	���|O�A�*


train_loss�PgB-�	�!       {��	��|O�A�*


train_loss�LgBhw!       {��	���|O�A�*


train_lossHHgB�T`�!       {��	���|O�A�*


train_lossDgB�&qT!       {��	>��|O�A�*


train_loss�?gB���&!       {��	���|O�A�*


train_lossv;gBĤ�6!       {��	t	�|O�A�*


train_loss67gB@f.�!       {��	@�|O�A�*


train_loss�2gB�Z!       {��	�"�|O�A�*


train_loss�.gB"a,!       {��	�/�|O�A�*


train_losss*gB��!       {��	*<�|O�A�*


train_loss5&gB���!       {��	QH�|O�A�*


train_loss�!gB�>�v!       {��	qT�|O�A�*


train_loss�gB�ړ�!       {��	�a�|O�A�*


train_loss�gB�H�!       {��	o�|O�A�*


train_lossFgBIU��!       {��	9|�|O�A�*


train_lossgB���!       {��	���|O�A�*


train_loss�gB���!       {��	��|O�A�*


train_loss�gB�Jf!       {��	���|O�A�*


train_losshgB�I4!       {��	q��|O�A�*


train_loss5 gB.���!       {��	ķ�|O�A�*


train_loss�fBE!BG!       {��	���|O�A�*


train_loss��fBy>!       {��	��|O�A�*


train_loss��fBA�8�!       {��	���|O�A�*


train_lossm�fB�R3!!       {��	x��|O�A�*


train_loss>�fB��?!       {��	���|O�A�*


train_loss�fBi�E�!       {��	}�|O�A�*


train_loss��fB���!       {��	��|O�A�*


train_loss��fB����!       {��	T�|O�A�*


train_loss��fB��2!       {��	�|O�A�*


train_lossb�fB��TM!       {��	�"�|O�A�*


train_loss:�fB�_�!       {��	�/�|O�A�*


train_loss�fBT=��!       {��	O<�|O�A�*


train_loss��fBkfb�!       {��	�M�|O�A�*


train_loss��fB�Kt�!       {��	�Z�|O�A�*


train_loss��fB����!       {��	�f�|O�A�*


train_loss}�fB(u�t!       {��	vr�|O�A�*


train_loss\�fBО��!       {��	1}�|O�A�*


train_loss:�fB~���!       {��	&��|O�A�*


train_loss�fBe���!       {��	��|O�A�*


train_loss��fB��n�!       {��	*��|O�A�*


train_lossܨfB�:�)!       {��	J��|O�A�*


train_loss��fB��w!       {��	s��|O�A�*


train_loss��fB��l�!       {��	���|O�A�*


train_loss��fBj�qw!       {��	v��|O�A�*


train_lossl�fB{qZ!       {��	��|O�A�*


train_lossU�fBq�-!       {��	�|O�A�*


train_loss<�fB�*s!       {��	�!�|O�A�*


train_loss#�fB�]�!       {��	s-�|O�A�*


train_loss�fB�V��!       {��	`>�|O�A�*


train_loss��fB�~�!       {��	�P�|O�A�*


train_loss�fB����!       {��	y\�|O�A�*


train_loss�{fBWp2^!       {��	�f�|O�A�*


train_loss�wfBHM�!       {��	-u�|O�A�*


train_loss�sfB�~�!       {��	���|O�A�*


train_loss�ofB�x$�!       {��	X��|O�A�*


train_loss�kfB^ �!       {��	��|O�A�*


train_loss~gfB�+�!       {��	>��|O�A�*


train_lossqcfB3���!       {��	ػ�|O�A�*


train_lossf_fBpQ�Y!       {��	���|O�A�*


train_lossY[fBA'%!       {��	p��|O�A�*


train_lossOWfBm �!       {��	���|O�A�*


train_lossGSfBثQ�!       {��	}��|O�A�*


train_loss<OfB���!       {��	���|O�A�*


train_loss6KfBny�!       {��	i��|O�A�*


train_loss0GfBV0�!       {��	�
�|O�A�*


train_loss,CfBj�!       {��	��|O�A�*


train_loss$?fBg�c !       {��	G �|O�A�*


train_loss!;fB߰�1!       {��	,�|O�A�*


train_loss7fBdgay!       {��	q6�|O�A�*


train_loss3fB�s�!       {��	A�|O�A�*


train_loss/fB����!       {��	{N�|O�A�*


train_loss+fB���!       {��	�\�|O�A�*


train_loss'fB��@�!       {��	�g�|O�A�*


train_loss #fB^��!       {��	�r�|O�A�*


train_loss!fByl�!       {��	=~�|O�A�*


train_loss%fB��g!       {��	���|O�A�*


train_loss*fB�eRt!       {��	W��|O�A�*


train_loss1fBE3Ԃ!       {��	��|O�A�*


train_loss7fB�,��!       {��	���|O�A�*


train_loss@fBU�&�!       {��	/��|O�A�*


train_lossGfB��L�!       {��	��|O�A�*


train_lossQfB�nYX!       {��	���|O�A�*


train_lossZ�eB�
6�!       {��	���|O�A�*


train_lossf�eB�nf9!       {��	+��|O�A�*


train_lossr�eB�s��!       {��	��|O�A�*


train_loss�eB�!       {��	b�|O�A�*


train_loss��eB���L!       {��	��|O�A�*


train_loss��eB�m7�!       {��	�)�|O�A�*


train_loss��eB����!       {��	�3�|O�A�*


train_loss��eBG��!       {��	�>�|O�A�*


train_loss��eB(�aC!       {��	wJ�|O�A�*


train_loss��eB��O!       {��	:Y�|O�A�*


train_loss��eB���B!       {��	�d�|O�A�*


train_loss�eB�"6!       {��	�p�|O�A�*


train_loss�eB+��	!       {��	Sz�|O�A�*


train_loss3�eBM>v�!       {��	̂�|O�A�*


train_lossH�eB0�d!       {��	i��|O�A�*


train_lossb�eBvy��!       {��	F��|O�A�*


train_lossy�eB����!       {��	���|O�A�*


train_loss��eBH�!       {��	���|O�A�*


train_loss��eB�56&!       {��	��|O�A�*


train_lossǴeB��L�!       {��	f��|O�A�*


train_loss�eB���!       {��	h��|O�A�*


train_loss�eB!4�!       {��	#��|O�A�*


train_loss �eBn�/�!       {��	~��|O�A�*


train_loss>�eBw�Lj!       {��	���|O�A�*


train_loss\�eB�g}�!       {��	���|O�A�*


train_loss�eBD�c!       {��	��|O�A�*


train_loss��eB�t!!       {��	��|O�A�*


train_losseB��.�!       {��	v�|O�A�*


train_loss�eB纤�!       {��	t%�|O�A�*


train_loss�eB9��!       {��	/�|O�A�*


train_loss,�eB­�7!       {��	:�|O�A�*


train_lossR�eB���j!       {��	D�|O�A�*


train_lossx�eB�L�W!       {��	�N�|O�A�*


train_loss�~eBSs�>!       {��	qW�|O�A�*


train_loss�zeB�M��!       {��	�_�|O�A�*


train_loss�veB�ė[!       {��	^h�|O�A�*


train_lossseB���|!       {��	�o�|O�A�*


train_lossEoeB	0Z!       {��	�w�|O�A�*


train_lossnkeB�&�!       {��	���|O�A�*


train_loss�geB�d�:!       {��	i��|O�A�*


train_loss�ceB1v{!       {��	��|O�A�*


train_loss�_eB�'��!       {��	R��|O�A�*


train_loss$\eB�AIl!       {��	{��|O�A�*


train_lossTXeBF�&�!       {��	&��|O�A�*


train_loss�TeBr��!       {��	��|O�A�*


train_loss�PeB���!       {��	���|O�A�*


train_loss�LeBGf!       {��	���|O�A�*


train_lossIeBM~hO!       {��	'��|O�A�*


train_lossMEeBH��!       {��	���|O�A�*


train_loss�AeB��Y!       {��	���|O�A�*


train_loss�=eB"s�!       {��	<��|O�A�*


train_loss�9eBV��!       {��	@��|O�A�*


train_loss!6eB�0v!       {��	���|O�A�*


train_lossZ2eBU��!       {��	���|O�A�*


train_loss�.eBf�V*!       {��	���|O�A�*


train_loss�*eB���k!       {��	H��|O�A�*


train_loss'eB�&3�!       {��	G�|O�A�*


train_loss?#eBf�U�!       {��	��|O�A�*


train_lossyeB����!       {��	��|O�A�*


train_loss�eB���#!       {��	��|O�A�*


train_loss�eB�,��!       {��	�)�|O�A�*


train_loss2eB����!       {��	C7�|O�A�*


train_lossoeBON�S!       {��	-E�|O�A�*


train_loss�eBX��!       {��	R�|O�A�*


train_loss�eB��!       {��	�`�|O�A�*


train_loss1eB�@�2!       {��	qp�|O�A�*


train_losspeBD\��!       {��	N}�|O�A�*


train_loss��dB��!       {��	n��|O�A�*


train_loss��dB��	�!       {��	���|O�A�*


train_loss9�dB�]�!       {��	Ǟ�|O�A�*


train_loss�dB��!       {��	ߧ�|O�A�*


train_loss��dBfS!       {��	��|O�A�*


train_loss
�dBo�i�!       {��	���|O�A�*


train_lossP�dBv��!       {��	���|O�A�*


train_loss��dB�0�k!       {��	���|O�A�*


train_loss��dBam[�!       {��	d��|O�A�*


train_loss(�dB�Q�c!       {��	|��|O�A�*


train_lossr�dB��s8!       {��	j��|O�A�*


train_loss��dBu.SF!       {��	���|O�A�*


train_loss
�dBA~�[!       {��	y��|O�A�*


train_lossT�dB���s!       {��	)��|O�A�*


train_loss��dBf�M!       {��	���|O�A�*


train_loss��dB�B�!       {��	^��|O�A�*


train_loss?�dB�jzq!       {��	i �|O�A�*


train_loss��dB��z!       {��	��|O�A�*


train_lossݺdB��!       {��	V�|O�A�*


train_loss-�dB�dA`!       {��	Z�|O�A�*


train_loss~�dB�9�!       {��	e�|O�A�*


train_lossЯdB;r�!       {��	:�|O�A�*


train_loss!�dB��U!       {��	k%�|O�A�*


train_lossv�dBIB��!       {��	�+�|O�A�*


train_lossȤdB ]�O!       {��	�1�|O�A�*


train_loss�dBw���!       {��	j7�|O�A�*


train_losst�dBj�B�!       {��	�=�|O�A�*


train_lossʙdB\�!       {��	,D�|O�A�*


train_loss �d
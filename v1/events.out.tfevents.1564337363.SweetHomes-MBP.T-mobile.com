       �K"	  �4yO�Abrain.Event:2[r��/      �$�`	��4yO�A"�_
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
l2_normalize/Maximum/yConst*
valueB
 *̼�+*
dtype0*
_output_shapes
: 
{
l2_normalize/MaximumMaximuml2_normalize/Suml2_normalize/Maximum/y*'
_output_shapes
:���������*
T0
c
l2_normalize/RsqrtRsqrtl2_normalize/Maximum*
T0*'
_output_shapes
:���������
b
l2_normalizeMulx-inputl2_normalize/Rsqrt*'
_output_shapes
:���������*
T0
\
WeightsConst*
dtype0*
_output_shapes

:*
valueB*    
|
Variable
VariableV2*
shared_name *
dtype0*
_output_shapes

:*
	container *
shape
:
�
Variable/AssignAssignVariableWeights*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class
loc:@Variable
i
Variable/readIdentityVariable*
_output_shapes

:*
T0*
_class
loc:@Variable
Q
BiasConst*
dtype0*
_output_shapes
:*
valueB*    
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
MatMulMatMull2_normalizeVariable/read*
T0*'
_output_shapes
:���������*
transpose_a( *
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
gradients/FillFillgradients/Shapegradients/grad_ys_0*
_output_shapes
: *
T0*

index_type0
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
gradients/Loss_grad/TileTilegradients/Loss_grad/Reshapegradients/Loss_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������
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
gradients/Loss_grad/CastCastgradients/Loss_grad/floordiv*
Truncate( *
_output_shapes
: *

DstT0*

SrcT0
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
gradients/output_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency-gradients/output_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
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
GradientDescent/learning_rateConst*
valueB
 *��L>*
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

train_lossScalarSummarytrain_loss/tagsLoss*
_output_shapes
: *
T0
^
train_loss_1/tagsConst*
valueB Btrain_loss_1*
dtype0*
_output_shapes
: 
W
train_loss_1ScalarSummarytrain_loss_1/tagsLoss*
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
save/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*)
value BBVariableB
Variable_1
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
save/restore_allNoOp^save/Assign^save/Assign_1"4��j;      ^#��	�z�4yO�AJ�v
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
shared_namestring �*1.13.12b'v1.13.0-rc2-5-g6612da8951'�_
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
"l2_normalize/Sum/reduction_indicesConst*
dtype0*
_output_shapes
: *
value	B :
�
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*'
_output_shapes
:���������*

Tidx0*
	keep_dims(*
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
VariableV2*
shape
:*
shared_name *
dtype0*
	container *
_output_shapes

:
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
BiasConst*
dtype0*
_output_shapes
:*
valueB*    
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
MatMulMatMull2_normalizeVariable/read*
T0*
transpose_a( *'
_output_shapes
:���������*
transpose_b( 
X
outputAddMatMulVariable_1/read*
T0*'
_output_shapes
:���������
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
gradients/Loss_grad/ProdProdgradients/Loss_grad/Shape_1gradients/Loss_grad/Const*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*

Tidx0*
	keep_dims( *
T0*
_output_shapes
:
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
gradients/output_grad/ShapeShapeMatMul*
_output_shapes
:*
T0*
out_type0
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
:*

Tidx0*
	keep_dims( 
�
gradients/output_grad/ReshapeReshapegradients/output_grad/Sumgradients/output_grad/Shape*'
_output_shapes
:���������*
T0*
Tshape0
�
gradients/output_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency-gradients/output_grad/BroadcastGradientArgs:1*

Tidx0*
	keep_dims( *
T0*
_output_shapes
:
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
T0*
transpose_a( *'
_output_shapes
:���������*
transpose_b(
�
gradients/MatMul_grad/MatMul_1MatMull2_normalize.gradients/output_grad/tuple/control_dependency*
T0*
transpose_a(*
_output_shapes

:*
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
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
_output_shapes

:*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1
b
GradientDescent/learning_rateConst*
valueB
 *��L>*
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

train_lossScalarSummarytrain_loss/tagsLoss*
_output_shapes
: *
T0
^
train_loss_1/tagsConst*
valueB Btrain_loss_1*
dtype0*
_output_shapes
: 
W
train_loss_1ScalarSummarytrain_loss_1/tagsLoss*
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
Variable_1save/RestoreV2:1*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:*
use_locking(
6
save/restore_allNoOp^save/Assign^save/Assign_1""-
	summaries 

train_loss:0
train_loss_1:0"�
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
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08�H�a        )��P	� �4yO�A*

train_loss_1g	D���0"       x=�	���4yO�A*

train_loss_1v��B9,"       x=�	K 5yO�A*

train_loss_1ТB���"       x=�		 5yO�A*

train_loss_1���B���a"       x=�	� 5yO�A*

train_loss_1��B� ��"       x=�	] 5yO�A*

train_loss_1�o�B���"       x=�	� 5yO�A*

train_loss_1��B���"       x=�	,) 5yO�A*

train_loss_1ڽ�BOt;c"       x=�	�/ 5yO�A*

train_loss_1�~�BOM�"       x=�	76 5yO�A	*

train_loss_1P�B��1"       x=�	`= 5yO�A
*

train_loss_1�0�B�K["       x=�	�D 5yO�A*

train_loss_1n�B�}n�"       x=�	�J 5yO�A*

train_loss_1�BI:�Q"       x=�	 Q 5yO�A*

train_loss_1�%�B.iF�"       x=�	-X 5yO�A*

train_loss_1�;�BV��"       x=�	�^ 5yO�A*

train_loss_1s]�B�}�j"       x=�	�d 5yO�A*

train_loss_1L��B��c�"       x=�	k 5yO�A*

train_loss_1���B%�y"       x=�	�q 5yO�A*

train_loss_1�BJ��"       x=�	�x 5yO�A*

train_loss_1�M�B ),�"       x=�	� 5yO�A*

train_loss_1ܡ�B�}J$"       x=�	� 5yO�A*

train_loss_1I��Bޢ�>"       x=�	�� 5yO�A*

train_loss_1�b�B���3"       x=�	� 5yO�A*

train_loss_1ϊB	�9"       x=�	� 5yO�A*

train_loss_1�B�B�l�n"       x=�	z� 5yO�A*

train_loss_1���B�9E,"       x=�	?� 5yO�A*

train_loss_1�=�B���"       x=�	t� 5yO�A*

train_loss_1$ňB >��"       x=�	� 5yO�A*

train_loss_1AR�B����"       x=�	�� 5yO�A*

train_loss_1��B��e�"       x=�	�� 5yO�A*

train_loss_1�|�B�� �"       x=�	�� 5yO�A*

train_loss_1�B>,mg"       x=�	|� 5yO�A *

train_loss_1廆Bs��="       x=�	�� 5yO�A!*

train_loss_1Gb�B�k�"       x=�	�� 5yO�A"*

train_loss_1��B�3#�"       x=�	�� 5yO�A#*

train_loss_1���B�d
�"       x=�	V� 5yO�A$*

train_loss_1`n�B�=zS"       x=�	�� 5yO�A%*

train_loss_1�$�Bu�|�"       x=�	�� 5yO�A&*

train_loss_1ބB�SU"       x=�	�5yO�A'*

train_loss_1���B�~b"       x=�	S5yO�A(*

train_loss_1�[�BY�^"       x=�	s5yO�A)*

train_loss_1�B|��o"       x=�	�5yO�A**

train_loss_1#�B̦!�"       x=�	�5yO�A+*

train_loss_1ݭ�BM�"       x=�	�!5yO�A,*

train_loss_1"y�B��"       x=�	�(5yO�A-*

train_loss_1�F�BEd��"       x=�	/5yO�A.*

train_loss_1��BǕY\"       x=�	�55yO�A/*

train_loss_1��B�s�("       x=�	<5yO�A0*

train_loss_1'��B�H��"       x=�	ZB5yO�A1*

train_loss_1P��BBC+�"       x=�	VH5yO�A2*

train_loss_1Sk�Bys�8"       x=�	LN5yO�A3*

train_loss_1E�B�3]	"       x=�	TT5yO�A4*

train_loss_1� �B�(p�"       x=�	}Z5yO�A5*

train_loss_1���B&Q0�"       x=�	a5yO�A6*

train_loss_1܁Bߋ�"       x=�	�f5yO�A7*

train_loss_1��B�Z"       x=�	m5yO�A8*

train_loss_1d��B a"       x=�	s5yO�A9*

train_loss_1��Bh�""       x=�	�x5yO�A:*

train_loss_1�c�BUa��"       x=�	�~5yO�A;*

train_loss_1�H�B�v��"       x=�	'�5yO�A<*

train_loss_1�.�Bp�)�"       x=�	a�5yO�A=*

train_loss_1��B�6z"       x=�	d�5yO�A>*

train_loss_1��B	1�"       x=�	��5yO�A?*

train_loss_1#�B9(�"       x=�	��5yO�A@*

train_loss_1рBN�<0"       x=�	��5yO�AA*

train_loss_1ܻ�B�M�"       x=�	��5yO�AB*

train_loss_1r��B�*@�"       x=�	5�5yO�AC*

train_loss_1˓�B���"       x=�	��5yO�AD*

train_loss_1ހ�B��M"       x=�	i�5yO�AE*

train_loss_1�n�B,�Jt"       x=�	}�5yO�AF*

train_loss_1
]�B^>,q"       x=�	�5yO�AG*

train_loss_1L�B�Q� "       x=�	,�5yO�AH*

train_loss_1�;�B,�hJ"       x=�	r�5yO�AI*

train_loss_1�+�B�Y%*"       x=�	��5yO�AJ*

train_loss_1��BFa��"       x=�	\�5yO�AK*

train_loss_1��B<y;�"       x=�	N�5yO�AL*

train_loss_1��Bw�"       x=�	��5yO�AM*

train_loss_13�B�%�a"       x=�	X�5yO�AN*

train_loss_1U�B��~q"       x=�	�5yO�AO*

train_loss_1M�B�{�w"       x=�	�5yO�AP*

train_loss_1�B{��"       x=�	�5yO�AQ*

train_loss_1�|Bn�k"       x=�	5yO�AR*

train_loss_1�dB���"       x=�	5yO�AS*

train_loss_1�MB�\+\"       x=�	�!5yO�AT*

train_loss_1 7B��C"       x=�	�'5yO�AU*

train_loss_1!B��(�"       x=�	/5yO�AV*

train_loss_1�Bk6Œ"       x=�	�55yO�AW*

train_loss_1��~Bdr��"       x=�	`<5yO�AX*

train_loss_1��~B��>{"       x=�	�B5yO�AY*

train_loss_1��~B(#�"       x=�	�H5yO�AZ*

train_loss_1��~B�|��"       x=�	O5yO�A[*

train_loss_1��~B�9��"       x=�	�T5yO�A\*

train_loss_1'�~B_BO."       x=�	�Z5yO�A]*

train_loss_1�~B�"       x=�	s`5yO�A^*

train_loss_1gr~B�""       x=�	�f5yO�A_*

train_loss_1a~B蕙�"       x=�	�l5yO�A`*

train_loss_1P~B�Ԡ"       x=�	�r5yO�Aa*

train_loss_1t?~B_��a"       x=�	�x5yO�Ab*

train_loss_1/~B�,��"       x=�	�~5yO�Ac*

train_loss_1~B�&��"       x=�	Ä5yO�Ad*

train_loss_1T~B�Y�"       x=�	�45yO�Ae*

train_loss_1��}B����"       x=�	�?5yO�Af*

train_loss_1��}B#_�"       x=�	�F5yO�Ag*

train_loss_1��}B{�#"       x=�	�M5yO�Ah*

train_loss_1��}Bhɍ{"       x=�	�T5yO�Ai*

train_loss_1]�}BY`�"       x=�	-\5yO�Aj*

train_loss_1�}B3=�"       x=�	c5yO�Ak*

train_loss_1�}B5���"       x=�	�i5yO�Al*

train_loss_1�}B���"       x=�	zo5yO�Am*

train_loss_1H�}B�	3/"       x=�	�v5yO�An*

train_loss_1�~}B�{�z"       x=�	�|5yO�Ao*

train_loss_1Qq}Bs+)�"       x=�	��5yO�Ap*

train_loss_1d}B�v)�"       x=�	U�5yO�Aq*

train_loss_1 W}Br2�"       x=�	�5yO�Ar*

train_loss_1J}Bq�#�"       x=�	��5yO�As*

train_loss_1B=}BZ�C�"       x=�	��5yO�At*

train_loss_1�0}B��`�"       x=�		�5yO�Au*

train_loss_1$}B%��"       x=�	��5yO�Av*

train_loss_1�}BQd��"       x=�	�5yO�Aw*

train_loss_1Q}B��<�"       x=�	��5yO�Ax*

train_loss_1 �|B�3�6"       x=�	Ͽ5yO�Ay*

train_loss_1	�|B\�u"       x=�	u�5yO�Az*

train_loss_1�|B�V�N"       x=�	>�5yO�A{*

train_loss_1)�|BD�l�"       x=�	1�5yO�A|*

train_loss_1]�|B�Ơ"       x=�	��5yO�A}*

train_loss_1��|B�V|6"       x=�	D�5yO�A~*

train_loss_1�|B�sD�"       x=�	�5yO�A*

train_loss_1��|B*5��#       ��wC	k�5yO�A�*

train_loss_1
�|B�"�#       ��wC	+�5yO�A�*

train_loss_1��|B� Sk#       ��wC	��5yO�A�*

train_loss_1Z�|B��V�#       ��wC	.5yO�A�*

train_loss_1|BlQ�#       ��wC	�
5yO�A�*

train_loss_1�s|B���,#       ��wC	5yO�A�*

train_loss_1�h|B��B#       ��wC	�5yO�A�*

train_loss_1�]|B]�`#       ��wC	.5yO�A�*

train_loss_1�R|B�u�#       ��wC	�#5yO�A�*

train_loss_1�G|B�J�#       ��wC	*5yO�A�*

train_loss_1 =|Bl��#       ��wC	05yO�A�*

train_loss_1/2|B+�"#       ��wC	265yO�A�*

train_loss_1i'|BM�y�#       ��wC	<5yO�A�*

train_loss_1�|B�/�#       ��wC	D5yO�A�*

train_loss_1|B8#P%#       ��wC	�J5yO�A�*

train_loss_1i|B���#       ��wC	"Q5yO�A�*

train_loss_1��{B$3�#       ��wC	CW5yO�A�*

train_loss_1P�{B�XZ#       ��wC	�]5yO�A�*

train_loss_1��{B�<_#       ��wC	�c5yO�A�*

train_loss_1_�{B�b�9#       ��wC	�i5yO�A�*

train_loss_1��{B� �;#       ��wC	p5yO�A�*

train_loss_1��{B�ݏ�#       ��wC	v5yO�A�*

train_loss_1F�{B�;8�#       ��wC	�{5yO�A�*

train_loss_1��{B[�#       ��wC	�5yO�A�*

train_loss_1��{B~�j�#       ��wC	3�5yO�A�*

train_loss_1��{B��}`#       ��wC	�5yO�A�*

train_loss_1R�{Bխ��#       ��wC	�5yO�A�*

train_loss_1(�{B~���#       ��wC	N�5yO�A�*

train_loss_1
�{B���N#       ��wC	��5yO�A�*

train_loss_1�v{BqÐ�#       ��wC	i�5yO�A�*

train_loss_1�l{Bjns#       ��wC	i�5yO�A�*

train_loss_1�b{B��[c#       ��wC	��5yO�A�*

train_loss_1�X{B���v#       ��wC	��5yO�A�*

train_loss_1�N{B"�,N#       ��wC	�5yO�A�*

train_loss_1�D{B����#       ��wC	P�5yO�A�*

train_loss_1;{Bak�#       ��wC	��5yO�A�*

train_loss_1"1{Bn���#       ��wC	�5yO�A�*

train_loss_1E'{Bi��6#       ��wC	�5yO�A�*

train_loss_1l{B����#       ��wC	i�5yO�A�*

train_loss_1�{B
7�#       ��wC	��5yO�A�*

train_loss_1�	{B���#       ��wC	9�5yO�A�*

train_loss_1 {B��W�#       ��wC	��5yO�A�*

train_loss_1V�zB�gna#       ��wC	��5yO�A�*

train_loss_1��zB���D#       ��wC	K5yO�A�*

train_loss_1��zBk�J9#       ��wC	�5yO�A�*

train_loss_1E�zB^�#       ��wC	�5yO�A�*

train_loss_1��zBCBo#       ��wC	I5yO�A�*

train_loss_1 �zB���#       ��wC	@5yO�A�*

train_loss_1d�zB%ϔN#       ��wC	G 5yO�A�*

train_loss_1вzB((L #       ��wC	p&5yO�A�*

train_loss_1D�zB`�5�#       ��wC	{,5yO�A�*

train_loss_1��zB`��V#       ��wC	{25yO�A�*

train_loss_15�zB��2�#       ��wC	�85yO�A�*

train_loss_1��zBL/�c#       ��wC	?5yO�A�*

train_loss_1>�zB�%[#       ��wC	0F5yO�A�*

train_loss_1�yzB��#       ��wC	'N5yO�A�*

train_loss_1ZpzBښ�g#       ��wC	�T5yO�A�*

train_loss_1�fzB��#       ��wC	�Z5yO�A�*

train_loss_1�]zB�<sE#       ��wC	b5yO�A�*

train_loss_1*TzB�Yq#       ��wC	�g5yO�A�*

train_loss_1�JzB���#       ��wC	�m5yO�A�*

train_loss_1yAzB��#       ��wC	�s5yO�A�*

train_loss_1'8zB�Ұ�#       ��wC	�y5yO�A�*

train_loss_1�.zB����#       ��wC	N�5yO�A�*

train_loss_1�%zB4��#       ��wC	Q�5yO�A�*

train_loss_1OzB+
�#       ��wC	��5yO�A�*

train_loss_1zB���#       ��wC	��5yO�A�*

train_loss_1�	zB<8�x#       ��wC	̘5yO�A�*

train_loss_1� zB�x��#       ��wC	˞5yO�A�*

train_loss_1q�yB w�#       ��wC	ߤ5yO�A�*

train_loss_1F�yBtr�#       ��wC	��5yO�A�*

train_loss_1�yB@?i #       ��wC	�5yO�A�*

train_loss_1��yB�;#       ��wC	E�5yO�A�*

train_loss_1��yBFW��#       ��wC	0h5yO�A�*

train_loss_1��yBL��#       ��wC	�q5yO�A�*

train_loss_1��yB~��m#       ��wC	�x5yO�A�*

train_loss_1��yB�P�b#       ��wC	�5yO�A�*

train_loss_1��yBc���#       ��wC	L�5yO�A�*

train_loss_1��yBjuw)#       ��wC	��5yO�A�*

train_loss_1�yBY|]R#       ��wC	��5yO�A�*

train_loss_1��yB���j#       ��wC	R�5yO�A�*

train_loss_1��yBLȩU#       ��wC	o�5yO�A�*

train_loss_1��yB5���#       ��wC	�5yO�A�*

train_loss_1�xyB\t#       ��wC	.�5yO�A�*

train_loss_1�oyB���#       ��wC	}�5yO�A�*

train_loss_1�fyBW���#       ��wC	R�5yO�A�*

train_loss_1�]yB�ȍ#       ��wC	��5yO�A�*

train_loss_1�TyB-C(#       ��wC	��5yO�A�*

train_loss_1LyB~�%#       ��wC	�5yO�A�*

train_loss_1;CyB)�f#       ��wC	�5yO�A�*

train_loss_1e:yB����#       ��wC	��5yO�A�*

train_loss_1�1yBs��#       ��wC	\�5yO�A�*

train_loss_1�(yB��j�#       ��wC	[�5yO�A�*

train_loss_1�yB���#       ��wC	��5yO�A�*

train_loss_15yB4-�#       ��wC	�5yO�A�*

train_loss_1pyB�M��#       ��wC	��5yO�A�*

train_loss_1�yB�^Y#       ��wC	 5yO�A�*

train_loss_1��xBxH�#       ��wC	F5yO�A�*

train_loss_1B�xB�ۭ�#       ��wC	'5yO�A�*

train_loss_1��xBR�{�#       ��wC	5yO�A�*

train_loss_1��xB�#       ��wC	u5yO�A�*

train_loss_17�xB$J #       ��wC	\#5yO�A�*

train_loss_1��xBz{�&#       ��wC	V*5yO�A�*

train_loss_1��xB/�#       ��wC	15yO�A�*

train_loss_1N�xB�$ ;#       ��wC	�75yO�A�*

train_loss_1��xBz��#       ��wC	W>5yO�A�*

train_loss_1�xB�n��#       ��wC	�D5yO�A�*

train_loss_1��xBb�Gw#       ��wC	K5yO�A�*

train_loss_1��xB��+�#       ��wC	Q5yO�A�*

train_loss_1l�xBݩ�#       ��wC	�W5yO�A�*

train_loss_1�xB�M�g#       ��wC	c_5yO�A�*

train_loss_1`�xB�Ǐ#       ��wC	f5yO�A�*

train_loss_1�{xB	I��#       ��wC	l5yO�A�*

train_loss_1esxB����#       ��wC	�q5yO�A�*

train_loss_1�jxBJ�� #       ��wC	[x5yO�A�*

train_loss_1wbxB�s*+#       ��wC	�~5yO�A�*

train_loss_1ZxB
�ܟ#       ��wC	��5yO�A�*

train_loss_1�QxBv"z�#       ��wC	��5yO�A�*

train_loss_10IxB�u�9#       ��wC	Ő5yO�A�*

train_loss_1�@xB�&��#       ��wC	��5yO�A�*

train_loss_1g8xB�#       ��wC	��5yO�A�*

train_loss_10xBf�C�#       ��wC	ۢ5yO�A�*

train_loss_1�'xB� bY#       ��wC	ۨ5yO�A�*

train_loss_1TxB�'A�#       ��wC	ޮ5yO�A�*

train_loss_1�xBߴN�#       ��wC	��5yO�A�*

train_loss_1�xBAm#       ��wC	�5yO�A�*

train_loss_1exB�X#       ��wC	H�5yO�A�*

train_loss_1�wB״�#       ��wC	)�5yO�A�*

train_loss_1��wB6� `#       ��wC	��5yO�A�*

train_loss_1��wB��&�#       ��wC	��5yO�A�*

train_loss_1V�wB��[�#       ��wC	�5yO�A�*

train_loss_1�wB� ��#       ��wC	��5yO�A�*

train_loss_1��wBc�#       ��wC	�5yO�A�*

train_loss_1��wBq/�7#       ��wC	t�5yO�A�*

train_loss_1��wB��f#       ��wC	��5yO�A�*

train_loss_1Z�wBN�#       ��wC	v�5yO�A�*

train_loss_11�wBv���#       ��wC	5yO�A�*

train_loss_1
�wB,6��#       ��wC	�5yO�A�*

train_loss_1�wB�Ts#       ��wC	�5yO�A�*

train_loss_1˛wB��#       ��wC	�5yO�A�*

train_loss_1��wB��n�#       ��wC	�+5yO�A�*

train_loss_1��wB)G�
#       ��wC	�45yO�A�*

train_loss_1��wB��Z#       ��wC	�;5yO�A�*

train_loss_1x{wB�@�#       ��wC	�B5yO�A�*

train_loss_1kswB/u��#       ��wC	K5yO�A�*

train_loss_1dkwBL��#       ��wC	�Q5yO�A�*

train_loss_1]cwB����#       ��wC	X5yO�A�*

train_loss_1Z[wB| �#       ��wC	�_5yO�A�*

train_loss_1]SwB#I&#       ��wC	Dg5yO�A�*

train_loss_1aKwB����#       ��wC	�m5yO�A�*

train_loss_1kCwB2q�&#       ��wC	�s5yO�A�*

train_loss_1u;wB���#       ��wC	z5yO�A�*

train_loss_1�3wBY�K�#       ��wC	|�5yO�A�*

train_loss_1�+wB����#       ��wC	V�5yO�A�*

train_loss_1�#wB_�7�#       ��wC	��5yO�A�*

train_loss_1�wB��p�#       ��wC	��5yO�A�*

train_loss_1�wB�I#       ��wC	�5yO�A�*

train_loss_1wBy���#       ��wC	A�5yO�A�*

train_loss_1)wB�V2g#       ��wC	s�5yO�A�*

train_loss_1O�vBq��h#       ��wC	q�5yO�A�*

train_loss_1z�vB�+�#       ��wC	��5yO�A�*

train_loss_1��vB8�#       ��wC	��5yO�A�*

train_loss_1��vBx%�#       ��wC	��5yO�A�*

train_loss_1�vB��.�#       ��wC	��5yO�A�*

train_loss_1D�vB�A��#       ��wC	��5yO�A�*

train_loss_1��vB��#       ��wC	��5yO�A�*

train_loss_1��vB�G�#       ��wC	��5yO�A�*

train_loss_1��vB���#       ��wC	7�5yO�A�*

train_loss_1F�vB�%�(#       ��wC	��5yO�A�*

train_loss_1��vB�UV#       ��wC	��5yO�A�*

train_loss_1ئvB�/��#       ��wC	R�5yO�A�*

train_loss_1%�vB��Ž#       ��wC	��5yO�A�*

train_loss_1x�vB�3��#       ��wC	��5yO�A�*

train_loss_1̏vB��!#       ��wC	?�	5yO�A�*

train_loss_1%�vB5b)G#       ��wC	��	5yO�A�*

train_loss_1��vB��@�#       ��wC	(�	5yO�A�*

train_loss_1�xvB�UC.#       ��wC	��	5yO�A�*

train_loss_1CqvB�:�q#       ��wC	��	5yO�A�*

train_loss_1�ivB�H�#       ��wC	��	5yO�A�*

train_loss_1bvB�=^#       ��wC	;�	5yO�A�*

train_loss_1yZvB����#       ��wC	��	5yO�A�*

train_loss_1�RvBl��,#       ��wC	��	5yO�A�*

train_loss_1[KvB�o�#       ��wC	<�	5yO�A�*

train_loss_1�CvBV�y#       ��wC	 �	5yO�A�*

train_loss_1H<vB�ƅ�#       ��wC	)
5yO�A�*

train_loss_1�4vB��x#       ��wC	�
5yO�A�*

train_loss_1B-vB�aL�#       ��wC	�
5yO�A�*

train_loss_1�%vB�x�#       ��wC	
5yO�A�*

train_loss_1JvB���#       ��wC	� 
5yO�A�*

train_loss_1�vB�2�#       ��wC	�'
5yO�A�*

train_loss_1^vB�n2#       ��wC	�-
5yO�A�*

train_loss_1�vB��3#       ��wC	5
5yO�A�*

train_loss_1| vB2��8#       ��wC	�;
5yO�A�*

train_loss_1�uBp3�#       ��wC	�A
5yO�A�*

train_loss_1��uB�6:�#       ��wC	�G
5yO�A�*

train_loss_1C�uB�J)y#       ��wC	O
5yO�A�*

train_loss_1��uB�ΰ�#       ��wC	�U
5yO�A�*

train_loss_1��uBO:�#       ��wC	:\
5yO�A�*

train_loss_1%�uB��p#       ��wC	$b
5yO�A�*

train_loss_1��uB���#       ��wC	�g
5yO�A�*

train_loss_1w�uB
ڗO#       ��wC	an
5yO�A�*

train_loss_1"�uBH�DB#       ��wC	qu
5yO�A�*

train_loss_1ӶuB���#       ��wC	k}
5yO�A�*

train_loss_1��uB3�:%#       ��wC	��
5yO�A�*

train_loss_1=�uB���#       ��wC	��
5yO�A�*

train_loss_1��uB�O#       ��wC	!�
5yO�A�*

train_loss_1��uBk=zT#       ��wC	��
5yO�A�*

train_loss_1o�uB���[#       ��wC	��
5yO�A�*

train_loss_14�uB"(D#       ��wC	��
5yO�A�*

train_loss_1��uB�&�e#       ��wC	��
5yO�A�*

train_loss_1�|uB����#       ��wC	ı
5yO�A�*

train_loss_1�uuBS��#       ��wC	��
5yO�A�*

train_loss_1XnuB"�M#       ��wC	��
5yO�A�*

train_loss_1(guB�S2]#       ��wC	�
5yO�A�*

train_loss_1�_uB��\#       ��wC	��
5yO�A�*

train_loss_1�XuB��O#       ��wC	��
5yO�A�*

train_loss_1�QuB����#       ��wC	��
5yO�A�*

train_loss_1�JuB���(#       ��wC	�
5yO�A�*

train_loss_1iCuBѴYB#       ��wC	�
5yO�A�*

train_loss_1M<uB���#       ��wC	!�
5yO�A�*

train_loss_135uB�}�<#       ��wC	x�
5yO�A�*

train_loss_1.uBl,�#       ��wC	��
5yO�A�*

train_loss_1'uB�t�#       ��wC	;�
5yO�A�*

train_loss_1�uBu���#       ��wC	�5yO�A�*

train_loss_1�uB"Ѫ�#       ��wC	�
5yO�A�*

train_loss_1�uB�ە#       ��wC	$5yO�A�*

train_loss_1�
uB�C��#       ��wC	75yO�A�*

train_loss_1�uB�r*#       ��wC	5yO�A�*

train_loss_1��tB���#       ��wC	1#5yO�A�*

train_loss_1��tB}��a#       ��wC	V)5yO�A�*

train_loss_1��tB3/S#       ��wC	I/5yO�A�*

train_loss_1��tBfI��#       ��wC	755yO�A�*

train_loss_1��tB����#       ��wC	;5yO�A�*

train_loss_1��tBܷ~�#       ��wC	�@5yO�A�*

train_loss_1��tB(wS�#       ��wC	,G5yO�A�*

train_loss_1��tB����#       ��wC	@O5yO�A�*

train_loss_1�tB�
�#       ��wC	�[5yO�A�*

train_loss_1#�tB����#       ��wC	�f5yO�A�*

train_loss_1<�tB(�cP#       ��wC	�n5yO�A�*

train_loss_1V�tB�=�Z#       ��wC	�5yO�A�*

train_loss_1t�tB�O�#       ��wC	��5yO�A�*

train_loss_1��tBAQ[�#       ��wC	p�5yO�A�*

train_loss_1��tB���N#       ��wC	2�5yO�A�*

train_loss_1�tB��_�#       ��wC	��5yO�A�*

train_loss_1
�tB��p#       ��wC	Y�5yO�A�*

train_loss_17�tBVQ6#       ��wC	}�5yO�A�*

train_loss_1d�tB�=#       ��wC	��5yO�A�*

train_loss_1�ytB����#       ��wC	��5yO�A�*

train_loss_1�rtBDB�x#       ��wC	�5yO�A�*

train_loss_1ltBc�"#       ��wC	�$5yO�A�*

train_loss_1;etB�&L�#       ��wC	�65yO�A�*

train_loss_1v^tB,<'�#       ��wC	dA5yO�A�*

train_loss_1�WtBQ�&�#       ��wC	QL5yO�A�*

train_loss_1�PtB|i�]#       ��wC	XW5yO�A�*

train_loss_1;JtB6	R�#       ��wC	5b5yO�A�*

train_loss_1�CtB�� #       ��wC	Ll5yO�A�*

train_loss_1�<tB�5|-#       ��wC	}t5yO�A�*

train_loss_16tBƯ@�#       ��wC	E~5yO�A�*

train_loss_1i/tB�|#       ��wC	��5yO�A�*

train_loss_1�(tB`_��#       ��wC	&�5yO�A�*

train_loss_1"tB��H#       ��wC	�5yO�A�*

train_loss_1dtBA=[#       ��wC	U�5yO�A�*

train_loss_1�tB��k#       ��wC	��5yO�A�*

train_loss_1tB�G�#       ��wC	�5yO�A�*

train_loss_1ytB*��	#       ��wC	��5yO�A�*

train_loss_1� tB���#       ��wC	j�5yO�A�*

train_loss_1?�sB�#       ��wC	�5yO�A�*

train_loss_1��sB�0S�#       ��wC	x�5yO�A�*

train_loss_1�sB��_u#       ��wC	��5yO�A�*

train_loss_1{�sB�՝#       ��wC	��5yO�A�*

train_loss_1��sB�BA�#       ��wC	��5yO�A�*

train_loss_1Z�sB9��#       ��wC	�5yO�A�*

train_loss_1��sB%0�#       ��wC	�5yO�A�*

train_loss_1C�sB:���#       ��wC	��5yO�A�*

train_loss_1��sB��k�#       ��wC	��5yO�A�*

train_loss_1:�sB�g!�#       ��wC	��5yO�A�*

train_loss_1��sB�V#       ��wC	��5yO�A�*

train_loss_18�sBluR#       ��wC	I�5yO�A�*

train_loss_1��sB!�Ҍ#       ��wC	�5yO�A�*

train_loss_1@�sBp��#       ��wC	��5yO�A�*

train_loss_1ǞsB�H�d#       ��wC	��5yO�A�*

train_loss_1Q�sB��L#       ��wC	I�5yO�A�*

train_loss_1ߑsB*��9#       ��wC	��5yO�A�*

train_loss_1m�sB�u��#       ��wC	�5yO�A�*

train_loss_1�sB�e��#       ��wC	�
5yO�A�*

train_loss_1�~sB�ź#       ��wC	�5yO�A�*

train_loss_1-xsB���.#       ��wC	m5yO�A�*

train_loss_1�qsB��{�#       ��wC	 "5yO�A�*

train_loss_1aksB�=D�#       ��wC	V(5yO�A�*

train_loss_1esB���g#       ��wC	/5yO�A�*

train_loss_1�^sBzu��#       ��wC	�55yO�A�*

train_loss_1EXsB�1T�#       ��wC	�<5yO�A�*

train_loss_1�QsBQ���#       ��wC	�B5yO�A�*

train_loss_1�KsBc���#       ��wC	
I5yO�A�*

train_loss_1>EsBT�#       ��wC	�N5yO�A�*

train_loss_1�>sB*m��#       ��wC	uU5yO�A�*

train_loss_1�8sB�dSr#       ��wC	�[5yO�A�*

train_loss_1M2sBQc�Q#       ��wC	)b5yO�A�*

train_loss_1,sBz%�)#       ��wC	{h5yO�A�*

train_loss_1�%sBH�h�#       ��wC	�o5yO�A�*

train_loss_1usB�廅#       ��wC	w5yO�A�*

train_loss_1.sB��	t#       ��wC	��5yO�A�*

train_loss_1�sB�d{$#       ��wC	��5yO�A�*

train_loss_1�sB׾2r#       ��wC	3�5yO�A�*

train_loss_1osB��#       ��wC	W�5yO�A�*

train_loss_15 sB؝U#       ��wC	'�5yO�A�*

train_loss_1��rBz�#       ��wC	��5yO�A�*

train_loss_1��rB�Ih#       ��wC	��5yO�A�*

train_loss_1��rBK��#       ��wC	Ȳ5yO�A�*

train_loss_1c�rBƓ�#       ��wC	$�5yO�A�*

train_loss_15�rBxd#       ��wC	�5yO�A�*

train_loss_1�rB���#       ��wC	��5yO�A�*

train_loss_1��rB�>UL#       ��wC	��5yO�A�*

train_loss_1��rBqk-#       ��wC	��5yO�A�*

train_loss_1��rB3Q��#       ��wC	��5yO�A�*

train_loss_1l�rB�լ�#       ��wC	�5yO�A�*

train_loss_1L�rB�="A#       ��wC	G�5yO�A�*

train_loss_1/�rB�!0\#       ��wC	�5yO�A�*

train_loss_1�rB�l#       ��wC	��5yO�A�*

train_loss_1��rB7k#       ��wC	��5yO�A�*

train_loss_1�rBO��Z#       ��wC	f�5yO�A�*

train_loss_1̝rB�x�#       ��wC	*5yO�A�*

train_loss_1��rB��#       ��wC	R5yO�A�*

train_loss_1��rB�}5#       ��wC	V5yO�A�*

train_loss_1��rB�<�#       ��wC	,5yO�A�*

train_loss_1��rB�/S_#       ��wC	/5yO�A�*

train_loss_1�rBN��r#       ��wC	!5yO�A�*

train_loss_1~yrB�~s�#       ��wC	�'5yO�A�*

train_loss_1xsrBEK$�#       ��wC	�-5yO�A�*

train_loss_1umrB��A#       ��wC	�35yO�A�*

train_loss_1tgrB�Ť�#       ��wC	�95yO�A�*

train_loss_1uarBE'Ȗ#       ��wC	@5yO�A�*

train_loss_1{[rBl���#       ��wC	$F5yO�A�*

train_loss_1~UrB�&�#       ��wC	L5yO�A�*

train_loss_1�OrBaX�#       ��wC	]R5yO�A�*

train_loss_1�IrB	9�)#       ��wC	CY5yO�A�*

train_loss_1�CrB��#       ��wC	�b5yO�A�*

train_loss_1�=rB��P�#       ��wC	m5yO�A�*

train_loss_1�7rB�<W�#       ��wC	Xu5yO�A�*

train_loss_1�1rB��hX#       ��wC	=|5yO�A�*

train_loss_1�+rB�%��#       ��wC	s�5yO�A�*

train_loss_1 &rB=��#       ��wC	��5yO�A�*

train_loss_1 rBXIz�#       ��wC	��5yO�A�*

train_loss_15rBX�#       ��wC	�5yO�A�*

train_loss_1UrBC�Ι#       ��wC	Û5yO�A�*

train_loss_1trBq�[#       ��wC	��5yO�A�*

train_loss_1�rBJR�n#       ��wC	K�5yO�A�*

train_loss_1�rBh�#       ��wC	ȱ5yO�A�*

train_loss_1��qB�#\�#       ��wC	4�5yO�A�*

train_loss_1�qBZ�~�#       ��wC	Ǿ5yO�A�*

train_loss_1:�qB��#       ��wC	��5yO�A�*

train_loss_1f�qB�M��#       ��wC	��5yO�A�*

train_loss_1��qB�l�$#       ��wC	��5yO�A�*

train_loss_1��qB;jX#       ��wC	��5yO�A�*

train_loss_1��qB��S#       ��wC	��5yO�A�*

train_loss_11�qBb��#       ��wC	��5yO�A�*

train_loss_1k�qB�ʫ@#       ��wC	��5yO�A�*

train_loss_1��qB5�>#       ��wC	��5yO�A�*

train_loss_1��qBz��d#       ��wC	�5yO�A�*

train_loss_1�qB�b��#       ��wC	�5yO�A�*

train_loss_1`�qBF�|]#       ��wC	z5yO�A�*

train_loss_1��qB�wg]#       ��wC	J	5yO�A�*

train_loss_1�qB;+U�#       ��wC	,5yO�A�*

train_loss_1/�qBH�H#       ��wC	I5yO�A�*

train_loss_1x�qB����#       ��wC	C5yO�A�*

train_loss_1ĚqB5��#       ��wC	�"5yO�A�*

train_loss_1�qBÞ�a#       ��wC	c)5yO�A�*

train_loss_1`�qB����#       ��wC	�/5yO�A�*

train_loss_1��qB��#       ��wC	�55yO�A�*

train_loss_1�qB��o#       ��wC	O<5yO�A�*

train_loss_1Z~qB� �#       ��wC	FB5yO�A�*

train_loss_1�xqB����#       ��wC	EH5yO�A�*

train_loss_1
sqB�_
B#       ��wC	�N5yO�A�*

train_loss_1gmqB5X#       ��wC	��5yO�A�*

train_loss_1�gqBr�O�#       ��wC	(	5yO�A�*

train_loss_1#bqB2���#       ��wC	(5yO�A�*

train_loss_1�\qB�@p#       ��wC	�5yO�A�*

train_loss_1�VqB�;q#       ��wC	T5yO�A�*

train_loss_1NQqB{E�#       ��wC	(#5yO�A�*

train_loss_1�KqB|���#       ��wC	,*5yO�A�*

train_loss_1FqBLOl�#       ��wC	725yO�A�*

train_loss_1�@qB�z�#       ��wC	�95yO�A�*

train_loss_1�:qB��%#       ��wC	�@5yO�A�*

train_loss_1k5qB*��#       ��wC	4G5yO�A�*

train_loss_1�/qB��=#       ��wC	�M5yO�A�*

train_loss_1O*qB ��#       ��wC	�T5yO�A�*

train_loss_1�$qB�N3#       ��wC	�\5yO�A�*

train_loss_1=qB��!�#       ��wC	
f5yO�A�*

train_loss_1�qB���#       ��wC	�o5yO�A�*

train_loss_13qB��n#       ��wC	)w5yO�A�*

train_loss_1�qB�qn�#       ��wC	~5yO�A�*

train_loss_1/	qB�<�K#       ��wC		�5yO�A�*

train_loss_1�qBt Ȓ#       ��wC	X�5yO�A�*

train_loss_14�pB�ym�#       ��wC	��5yO�A�*

train_loss_1��pB�'�L#       ��wC	0�5yO�A�*

train_loss_1A�pB��l�#       ��wC	��5yO�A�*

train_loss_1��pBC�/#       ��wC	��5yO�A�*

train_loss_1W�pB�O\#       ��wC	W�5yO�A�*

train_loss_1��pB�Ҵ�#       ��wC	5�5yO�A�*

train_loss_1q�pB����#       ��wC	��5yO�A�*

train_loss_1�pBaa�X#       ��wC	��5yO�A�*

train_loss_1��pBi�#       ��wC	��5yO�A�*

train_loss_1*�pB?-��#       ��wC	��5yO�A�*

train_loss_1��pBe��#       ��wC	H�5yO�A�*

train_loss_1[�pB
��f#       ��wC	3�5yO�A�*

train_loss_1��pB���S#       ��wC	��5yO�A�*

train_loss_1��pB��d#       ��wC	��5yO�A�*

train_loss_10�pB��[�#       ��wC	D�5yO�A�*

train_loss_1άpB^��#       ��wC	��5yO�A�*

train_loss_1r�pBɊ��#       ��wC	25yO�A�*

train_loss_1�pBo�M�#       ��wC	l	5yO�A�*

train_loss_1��pBԽK�#       ��wC	5yO�A�*

train_loss_1c�pBf$��#       ��wC	U5yO�A�*

train_loss_1�pB_44�#       ��wC	�5yO�A�*

train_loss_1��pB�:g#       ��wC	h#5yO�A�*

train_loss_1d�pBʱ��#       ��wC	�)5yO�A�*

train_loss_1�pB���#       ��wC	�05yO�A�*

train_loss_1�|pB�7��#       ��wC	e85yO�A�*

train_loss_1xwpB�3��#       ��wC	?5yO�A�*

train_loss_1.rpB��3�#       ��wC	�E5yO�A�*

train_loss_1�lpBS���#       ��wC	L5yO�A�*

train_loss_1�gpBL�YE#       ��wC	eR5yO�A�*

train_loss_1VbpBO�u�#       ��wC	Y5yO�A�*

train_loss_1]pB����#       ��wC	�_5yO�A�*

train_loss_1�WpB����#       ��wC	sf5yO�A�*

train_loss_1�RpB�{#       ��wC	fl5yO�A�*

train_loss_1RMpB5a�(#       ��wC	�r5yO�A�*

train_loss_1HpB����#       ��wC	�x5yO�A�*

train_loss_1�BpBFG1^#       ��wC	g5yO�A�*

train_loss_1�=pBHk�B#       ��wC	��5yO�A�*

train_loss_1j8pB��J#       ��wC	��5yO�A�*

train_loss_163pB����#       ��wC	Ց5yO�A�*

train_loss_1.pB��#       ��wC	��5yO�A�*

train_loss_1�(pB�` F#       ��wC	��5yO�A�*

train_loss_1�#pBw2J#       ��wC	�5yO�A�*

train_loss_1ppBZ8.�#       ��wC	G�5yO�A�*

train_loss_1FpBժ9#       ��wC	.�5yO�A�*

train_loss_1pB�K�#       ��wC	��5yO�A�*

train_loss_1�pB�"I�#       ��wC	7�5yO�A�*

train_loss_1�	pB���$#       ��wC	]�5yO�A�*

train_loss_1�pB�%�#       ��wC	��5yO�A�*

train_loss_1��oB]%)#       ��wC	N�5yO�A�*

train_loss_1^�oBcM�^#       ��wC	
�5yO�A�*

train_loss_1>�oB�Ü�#       ��wC	��5yO�A�*

train_loss_1�oBY�3#       ��wC	%�5yO�A�*

train_loss_1�oB*l�[#       ��wC	9�5yO�A�*

train_loss_1��oB��.�#       ��wC	��5yO�A�*

train_loss_1��oB�Q)#       ��wC	�5yO�A�*

train_loss_1��oBNS;X#       ��wC	?�5yO�A�*

train_loss_1��oBڰ.#       ��wC	�5yO�A�*

train_loss_1��oB���`#       ��wC	�5yO�A�*

train_loss_1z�oB߮NR#       ��wC	�5yO�A�*

train_loss_1h�oB\dx#       ��wC	�5yO�A�*

train_loss_1Z�oB���#       ��wC	�5yO�A�*

train_loss_1L�oB�y�#       ��wC	$5yO�A�*

train_loss_1@�oB��%n#       ��wC	�)5yO�A�*

train_loss_17�oBJ t#       ��wC	�/5yO�A�*

train_loss_1/�oB����#       ��wC	�55yO�A�*

train_loss_1'�oB���##       ��wC	�=5yO�A�*

train_loss_1$�oB�,#       ��wC	-D5yO�A�*

train_loss_1�oB��]#       ��wC	�K5yO�A�*

train_loss_1�oBF�##       ��wC	"R5yO�A�*

train_loss_1�oB�r�#       ��wC	>X5yO�A�*

train_loss_1 �oB�c�#       ��wC	5^5yO�A�*

train_loss_1#�oB����#       ��wC	<d5yO�A�*

train_loss_1(�oBAκ#       ��wC	j5yO�A�*

train_loss_13�oB���E#       ��wC	up5yO�A�*

train_loss_19|oB|���#       ��wC	\v5yO�A�*

train_loss_1BwoB�D��#       ��wC	�|5yO�A�*

train_loss_1OroB��5�#       ��wC	ӂ5yO�A�*

train_loss_1[moB�=�#       ��wC	�5yO�A�*

train_loss_1ihoB�n�#       ��wC	>�5yO�A�*

train_loss_1{coB�<ό#       ��wC	�5yO�A�*

train_loss_1�^oBH '�#       ��wC	^E5yO�A�*

train_loss_1�YoB��#       ��wC	�P5yO�A�*

train_loss_1�ToB����#       ��wC	�W5yO�A�*

train_loss_1�OoBY��#       ��wC	^5yO�A�*

train_loss_1�JoBz��#       ��wC	�e5yO�A�*

train_loss_1FoB2�#       ��wC		l5yO�A�*

train_loss_1AoB���#       ��wC	�q5yO�A�*

train_loss_1;<oBy��#       ��wC	�w5yO�A�*

train_loss_1[7oB"L�]#       ��wC	45yO�A�*

train_loss_1{2oBt��`#       ��wC	��5yO�A�*

train_loss_1�-oBLa��#       ��wC	��5yO�A�*

train_loss_1�(oB��5#       ��wC	h�5yO�A�*

train_loss_1�#oB�T2m#       ��wC	��5yO�A�*

train_loss_1oBe��#       ��wC	��5yO�A�*

train_loss_18oB<�=#       ��wC	¤5yO�A�*

train_loss_1boBË�x#       ��wC	��5yO�A�*

train_loss_1�oBz,h�#       ��wC	%�5yO�A�*

train_loss_1�oB���#       ��wC	��5yO�A�*

train_loss_1�oB�/#       ��wC	��5yO�A�*

train_loss_1oB����#       ��wC	��5yO�A�*

train_loss_1M�nB�ȳ#       ��wC	�5yO�A�*

train_loss_1�nB�8j�#       ��wC	��5yO�A�*

train_loss_1��nBr��#       ��wC	
�5yO�A�*

train_loss_1��nB #       ��wC	C�5yO�A�*

train_loss_1#�nB�D_>#       ��wC	m�5yO�A�*

train_loss_1^�nB�l	L#       ��wC	:�5yO�A�*

train_loss_1��nB��5�#       ��wC	�5yO�A�*

train_loss_1��nBŭ�^#       ��wC	n�5yO�A�*

train_loss_1�nBt��g#       ��wC	��5yO�A�*

train_loss_1T�nB���#       ��wC	5yO�A�*

train_loss_1��nBZ�C�#       ��wC	�5yO�A�*

train_loss_1��nB�G�#       ��wC	�5yO�A�*

train_loss_1�nB.�qJ#       ��wC	�5yO�A�*

train_loss_1f�nB��}�#       ��wC	6!5yO�A�*

train_loss_1��nB;�x#       ��wC	,'5yO�A�*

train_loss_1��nB�Xҏ#       ��wC	^-5yO�A�*

train_loss_1@�nB�|�#       ��wC	D35yO�A�*

train_loss_1��nB���-#       ��wC	\95yO�A�*

train_loss_1ڧnBL��x#       ��wC	g?5yO�A�*

train_loss_1)�nB�|��#       ��wC	JE5yO�A�*

train_loss_1|�nB����#       ��wC	M5yO�A�*

train_loss_1̙nBh �T#       ��wC	~T5yO�A�*

train_loss_1�nB
��#       ��wC	�Z5yO�A�*

train_loss_1t�nBC�O�#       ��wC	�`5yO�A�*

train_loss_1͋nBN�#       ��wC	Zg5yO�A�*

train_loss_1$�nB]6�Z#       ��wC	�m5yO�A�*

train_loss_1{�nB�g�#       ��wC	�s5yO�A�*

train_loss_1�}nB+��X#       ��wC	�y5yO�A�*

train_loss_16ynB��>#       ��wC	�5yO�A�*

train_loss_1�tnB?��#       ��wC	ۅ5yO�A�*

train_loss_1�onB*�|�#       ��wC	��5yO�A�*

train_loss_1SknB����#       ��wC	�5yO�A�*

train_loss_1�fnB8�k#       ��wC	�5yO�A�*

train_loss_1bnB\��#       ��wC	��5yO�A�*

train_loss_1}]nB�B�#       ��wC	<�5yO�A�*

train_loss_1�XnB�%Z�#       ��wC	\�5yO�A�*

train_loss_1LTnB�]�,#       ��wC	��5yO�A�*

train_loss_1�OnB��V�#       ��wC	_�5yO�A�*

train_loss_1!KnB�˦�#       ��wC	��5yO�A�*

train_loss_1�FnB�^�{#       ��wC	w�5yO�A�*

train_loss_1�AnBѦkA#       ��wC	��5yO�A�*

train_loss_1l=nB�z��#       ��wC	�5yO�A�*

train_loss_1�8nBjn?
#       ��wC	��5yO�A�*

train_loss_1N4nB=��g#       ��wC	��5yO�A�*

train_loss_1�/nB�S4�#       ��wC	�5yO�A�*

train_loss_16+nBA[��#       ��wC	5�5yO�A�*

train_loss_1�&nB�9�#       ��wC	��5yO�A�*

train_loss_1#"nB4R~�#       ��wC	��5yO�A�*

train_loss_1�nB�п#       ��wC	��5yO�A�*

train_loss_1nB�r��#       ��wC	B5yO�A�*

train_loss_1�nB"�F�#       ��wC	�
5yO�A�*

train_loss_1nBS�8#       ��wC	E5yO�A�*

train_loss_1�nBE��#       ��wC	5yO�A�*

train_loss_1nB���#       ��wC	�5yO�A�*

train_loss_1�nB�4��#       ��wC	�#5yO�A�*

train_loss_1�mB�7��#       ��wC	�)5yO�A�*

train_loss_1��mB�/��#       ��wC	05yO�A�*

train_loss_1�mB<~��#       ��wC	�55yO�A�*

train_loss_1��mB12�<#       ��wC	�;5yO�A�*

train_loss_1.�mB)��#       ��wC	tA5yO�A�*

train_loss_1��mB�Q2^#       ��wC	�G5yO�A�*

train_loss_1A�mBG_�#       ��wC	rM5yO�A�*

train_loss_1��mBr �#       ��wC	�S5yO�A�*

train_loss_1[�mBW�}#       ��wC	�[5yO�A�*

train_loss_1��mB�D-�#       ��wC	�b5yO�A�*

train_loss_1|�mB����#       ��wC	i5yO�A�*

train_loss_1�mB^:��#       ��wC	Po5yO�A�*

train_loss_1��mB]��#       ��wC	Ku5yO�A�*

train_loss_15�mB��#       ��wC	5{5yO�A�*

train_loss_1˿mB��B#       ��wC	Q�5yO�A�*

train_loss_1b�mB�Ĭ�#       ��wC	v�5yO�A�*

train_loss_1��mB�kP}#       ��wC	i�5yO�A�*

train_loss_1��mB� �#       ��wC	��5yO�A�*

train_loss_11�mB-_	�#       ��wC	��5yO�A�*

train_loss_1̩mByK �#       ��wC	��5yO�A�*

train_loss_1k�mB��9�#       ��wC	w�5yO�A�*

train_loss_1	�mB����#       ��wC	��5yO�A�*

train_loss_1��mB�[5#       ��wC	��5yO�A�*

train_loss_1K�mBSw��#       ��wC	t�5yO�A�*

train_loss_1�mB�k�#       ��wC	��5yO�A�*

train_loss_1��mBCxR�#       ��wC	8i5yO�A�*

train_loss_1;�mB.m9#       ��wC	�v5yO�A�*

train_loss_1��mB�e#       ��wC	s5yO�A�*

train_loss_1��mB�A�#       ��wC	L�5yO�A�*

train_loss_13~mB�1��#       ��wC	��5yO�A�*

train_loss_1�ymB,�{#       ��wC	��5yO�A�*

train_loss_1�umB� �#       ��wC	,�5yO�A�*

train_loss_17qmB����#       ��wC	��5yO�A�*

train_loss_1�lmB���`#       ��wC	��5yO�A�*

train_loss_1�hmBs{�B#       ��wC	ޭ5yO�A�*

train_loss_1GdmB7���#       ��wC	��5yO�A�*

train_loss_1�_mB�=��#       ��wC	��5yO�A�*

train_loss_1�[mB�'4�#       ��wC	��5yO�A�*

train_loss_1bWmB*�\#       ��wC	��5yO�A�*

train_loss_1SmB�yS1#       ��wC	B�5yO�A�*

train_loss_1�NmBDB�d#       ��wC	�5yO�A�*

train_loss_1�JmB���#       ��wC	�5yO�A�*

train_loss_1FFmB�
��#       ��wC	��5yO�A�*

train_loss_1BmB��'=#       ��wC	��5yO�A�*

train_loss_1�=mBĵ�	#       ��wC	(�5yO�A�*

train_loss_1z9mBx"#       ��wC	��5yO�A�*

train_loss_1:5mB�G�#       ��wC	 �5yO�A�*

train_loss_1�0mB��4##       ��wC	�5yO�A�*

train_loss_1�,mB��#       ��wC	�
5yO�A�*

train_loss_1�(mBc��B#       ��wC	�5yO�A�*

train_loss_1C$mB̃
�#       ��wC	Y5yO�A�*

train_loss_1 mB̜��#       ��wC	\5yO�A�*

train_loss_1�mB�b��#       ��wC	[#5yO�A�*

train_loss_1�mBXhz#       ��wC	+5yO�A�*

train_loss_1amBS�ZG#       ��wC	�15yO�A�*

train_loss_1.mB�\�#       ��wC	85yO�A�*

train_loss_1�
mB��#       ��wC	y>5yO�A�*

train_loss_1�mB�1�#       ��wC	�D5yO�A�*

train_loss_1�mBc�06#       ��wC	�J5yO�A�*

train_loss_1b�lBG�#�#       ��wC	Q5yO�A�*

train_loss_13�lBm4e#       ��wC	�V5yO�A�*

train_loss_1�lB��k#       ��wC	9]5yO�A�*

train_loss_1��lBEB*|#       ��wC	#c5yO�A�*

train_loss_1��lB!��@#       ��wC	�k5yO�A�*

train_loss_1�lB8R|#       ��wC	\r5yO�A�*

train_loss_1U�lB9�e�#       ��wC	y5yO�A�*

train_loss_10�lB&��#       ��wC	55yO�A�*

train_loss_1�lBT���#       ��wC	U�5yO�A�*

train_loss_1��lB�:�#       ��wC	3�5yO�A�*

train_loss_1��lBV�#       ��wC	C�5yO�A�*

train_loss_1��lB�t#       ��wC	S�5yO�A�*

train_loss_1v�lB
��#       ��wC	'�5yO�A�*

train_loss_1W�lBq�O_#       ��wC	L�5yO�A�*

train_loss_15�lB�Ӳ#       ��wC	.�5yO�A�*

train_loss_1�lB��	�#       ��wC	X�5yO�A�*

train_loss_1��lB�y#       ��wC	x�5yO�A�*

train_loss_1ܷlB5��#       ��wC	I�5yO�A�*

train_loss_1��lB��y;#       ��wC	��5yO�A�*

train_loss_1��lB�/#�#       ��wC	��5yO�A�*

train_loss_1��lB&��#       ��wC	��5yO�A�*

train_loss_1u�lB�DP#       ��wC	��5yO�A�*

train_loss_1`�lB�Q�#       ��wC	��5yO�A�*

train_loss_1I�lB^�#       ��wC	��5yO�A�*

train_loss_13�lBA��#       ��wC	��5yO�A�*

train_loss_1!�lB:C+#       ��wC	��5yO�A�*

train_loss_1�lBw /�#       ��wC	��5yO�A�*

train_loss_1��lB�h΃#       ��wC		�5yO�A�*

train_loss_1�lB���v#       ��wC	G5yO�A�*

train_loss_1�lB��EG#       ��wC	G5yO�A�*

train_loss_1ӂlB�:c#       ��wC	_5yO�A�*

train_loss_1�~lBS��^#       ��wC	V5yO�A�*

train_loss_1�zlB=���#       ��wC	5yO�A�*

train_loss_1�vlB@�&�#       ��wC	K%5yO�A�*

train_loss_1�rlB��#       ��wC	05yO�A�*

train_loss_1�nlB#�\�#       ��wC	kL5yO�A�*

train_loss_1�jlB	e�#       ��wC	�_5yO�A�*

train_loss_1�flB�l��#       ��wC	o5yO�A�*

train_loss_1�blBH��(#       ��wC	�w5yO�A�*

train_loss_1�^lBFӥO#       ��wC	F5yO�A�*

train_loss_1�ZlB���a#       ��wC	4�5yO�A�*

train_loss_1�VlB�̪#       ��wC	Y�5yO�A�*

train_loss_1�RlB��|#       ��wC	[�5yO�A�*

train_loss_1�NlB�P��#       ��wC	��5yO�A�*

train_loss_1�JlB��\#       ��wC	Ӟ5yO�A�*

train_loss_1�FlB��Ұ#       ��wC	Ƥ5yO�A�*

train_loss_1�BlBN�|E#       ��wC	��5yO�A�*

train_loss_1�>lB��? #       ��wC	5�5yO�A�*

train_loss_1�:lB��>�#       ��wC	ظ5yO�A�*

train_loss_1�6lBX�|a#       ��wC	o�5yO�A�*

train_loss_1�2lB��S�#       ��wC	��5yO�A�*

train_loss_1�.lBZ�s#       ��wC	[�5yO�A�*

train_loss_1�*lB��=#       ��wC	��5yO�A�*

train_loss_1�&lBjo�#       ��wC	��5yO�A�*

train_loss_1�"lB�&R#       ��wC	e 5yO�A�*

train_loss_1�lBo�< #       ��wC	�5yO�A�*

train_loss_1�lBr�#       ��wC	�5yO�A�*

train_loss_1lB����#       ��wC	�5yO�A�*

train_loss_1lB�9{�#       ��wC	�5yO�A�*

train_loss_10lB�4m#       ��wC	5&5yO�A�*

train_loss_1ClB�+sM#       ��wC	�25yO�A�*

train_loss_1YlB�cz�#       ��wC	�<5yO�A�*

train_loss_1llB���#       ��wC	oF5yO�A�*

train_loss_1��kBuh��#       ��wC	�k5yO�A�*

train_loss_1��kBa��#       ��wC	҉5yO�A�*

train_loss_1��kBk�#       ��wC	[�5yO�A�*

train_loss_1��kB���#       ��wC	G�5yO�A�*

train_loss_1��kBOB#       ��wC	��5yO�A�*

train_loss_1�kB���#       ��wC	��5yO�A�*

train_loss_1!�kBT��#       ��wC	��5yO�A�*

train_loss_1C�kBj-'+#       ��wC	<5yO�A�*

train_loss_1_�kB�?$�#       ��wC	b/5yO�A�*

train_loss_1��kBD�0d#       ��wC	JH5yO�A�*

train_loss_1��kBn;�#       ��wC	�a5yO�A�*

train_loss_1��kBUy�#       ��wC	�m5yO�A�*

train_loss_1��kB-��-#       ��wC	�5yO�A�*

train_loss_1�kBV�C�#       ��wC	̲5yO�A�*

train_loss_10�kB��#       ��wC	Q�5yO�A�*

train_loss_1W�kBs��#       ��wC	��5yO�A�*

train_loss_1}�kB�:�#       ��wC	t�5yO�A�*

train_loss_1��kB�_�#       ��wC	'�5yO�A�*

train_loss_1йkB/�l#       ��wC	h�5yO�A�*

train_loss_1��kB���M#       ��wC	��5yO�A�*

train_loss_1&�kBH��#       ��wC	05yO�A�*

train_loss_1T�kBwiG8#       ��wC	a5yO�A�*

train_loss_1��kB� �d#       ��wC	�#5yO�A�*

train_loss_1��kB^��#       ��wC	�+5yO�A�*

train_loss_1ޢkB��(s#       ��wC	�35yO�A�*

train_loss_1�kB�G��#       ��wC	:<5yO�A�*

train_loss_1@�kBQ(�%#       ��wC	%D5yO�A�*

train_loss_1q�kBc�/�#       ��wC	#M5yO�A�*

train_loss_1��kB�NL�#       ��wC	�[5yO�A�*

train_loss_1ڏkB�PR#       ��wC	If5yO�A�*

train_loss_1�kB7�#       ��wC	no5yO�A�*

train_loss_1H�kB�`�D#       ��wC	b�5yO�A�*

train_loss_1�kB�9�#       ��wC	�5yO�A�*

train_loss_1��kB5՞##       ��wC	G�5yO�A�*

train_loss_1�|kB zn�#       ��wC	��5yO�A�*

train_loss_1*ykB|�r#       ��wC	2�5yO�A�*

train_loss_1eukB-$!#       ��wC	G�5yO�A�*

train_loss_1�qkBރ�Q#       ��wC	��5yO�A�*

train_loss_1�mkB�q[�#       ��wC	�5yO�A�*

train_loss_1jkB�a:#       ��wC	 �5yO�A�*

train_loss_1\fkB<Ί#       ��wC	��5yO�A�*

train_loss_1�bkB�]?�#       ��wC	��5yO�A�*

train_loss_1�^kB�y~r#       ��wC	5yO�A�*

train_loss_1"[kBU9�l#       ��wC	,5yO�A�*

train_loss_1dWkBA�&#       ��wC	�5yO�A�*

train_loss_1�SkB��iV#       ��wC	�#5yO�A�*

train_loss_1�OkB,��#       ��wC	V+5yO�A�*

train_loss_15LkB?f@>#       ��wC	�35yO�A�*

train_loss_1|HkB4��#       ��wC	�;5yO�A�*

train_loss_1�DkB�(�#       ��wC	�L5yO�A�*

train_loss_1AkB����#       ��wC	�X5yO�A�*

train_loss_1X=kB�=#       ��wC	|d5yO�A�*

train_loss_1�9kBi�3�#       ��wC	�o5yO�A�*

train_loss_1�5kBF� l#       ��wC	�x5yO�A�*

train_loss_1;2kB��#       ��wC	܀5yO�A�*

train_loss_1�.kB��#       ��wC	 �5yO�A�*

train_loss_1�*kB�m8#       ��wC	J�5yO�A�*

train_loss_1%'kB�ƫ�#       ��wC	P�5yO�A�*

train_loss_1x#kB�L�#       ��wC	��5yO�A�*

train_loss_1�kB�@�T#       ��wC	��5yO�A�*

train_loss_1kB�b�#       ��wC	n�5yO�A�*

train_loss_1nkB��4_#       ��wC	��5yO�A�*

train_loss_1�kB2��#       ��wC	5�5yO�A�*

train_loss_1kB1�k`#       ��wC	��5yO�A�*

train_loss_1lkBʂ��#       ��wC	��5yO�A�*

train_loss_1�	kBHe#       ��wC	q�5yO�A�*

train_loss_1kB]ݗ=#       ��wC	�5yO�A�*

train_loss_1tkB#O�#       ��wC	
5yO�A�*

train_loss_1��jB�hwR#       ��wC	�5yO�A�*

train_loss_1*�jBiU��#       ��wC	�,5yO�A�*

train_loss_1��jB��$#       ��wC	j45yO�A�*

train_loss_1��jBǞ�#       ��wC	�:5yO�A�*

train_loss_1@�jB��#       ��wC	�@5yO�A�*

train_loss_1��jBc���#       ��wC	�F5yO�A�*

train_loss_1��jBT���#       ��wC	�L5yO�A�*

train_loss_1]�jBe��#       ��wC	�S5yO�A�*

train_loss_1��jBZ�}�#       ��wC	�Y5yO�A�*

train_loss_1 �jB�w[#       ��wC	�_5yO�A�*

train_loss_1��jBwU��#       ��wC	�e5yO�A�*

train_loss_1��jBbݩ#       ��wC	�k5yO�A�*

train_loss_1L�jB���#       ��wC	r5yO�A�*

train_loss_1��jB|�<#       ��wC	�x5yO�A�*

train_loss_1�jB�h#       ��wC	�~5yO�A�*

train_loss_1��jBR(#�#       ��wC	ۆ5yO�A�*

train_loss_1��jB�ll�#       ��wC	}�5yO�A�*

train_loss_1Q�jB����#       ��wC	ٚ5yO�A�*

train_loss_1��jB@�
#       ��wC	7�5yO�A�*

train_loss_1&�jB9��#       ��wC	K�5yO�A�*

train_loss_1��jB�ț#       ��wC	ݵ5yO�A�*

train_loss_1��jB^�6`#       ��wC	#�5yO�A�*

train_loss_1l�jB�\��#       ��wC	��5yO�A�*

train_loss_1٫jBWL��#       ��wC	��5yO�A�*

train_loss_1J�jB�ji#       ��wC	��5yO�A�*

train_loss_1��jB!'B#       ��wC	�5yO�A�*

train_loss_1,�jBR��#       ��wC	n�5yO�A�*

train_loss_1��jB3J�#       ��wC	��5yO�A�*

train_loss_1�jB��#       ��wC	=�5yO�A�*

train_loss_1��jBE���#       ��wC	��5yO�A�*

train_loss_1��jB��(�#       ��wC	��5yO�A�*

train_loss_1l�jB��#       ��wC	G  5yO�A�*

train_loss_1�jB�S��#       ��wC	� 5yO�A�*

train_loss_1[�jB�:@M#       ��wC	
 5yO�A�*

train_loss_1҄jB3pvi#       ��wC	 5yO�A�*

train_loss_1M�jB�(�}#       ��wC	q� 5yO�A�*

train_loss_1�}jB{�r#       ��wC	-� 5yO�A�*

train_loss_1@zjB�:��#       ��wC	�� 5yO�A�*

train_loss_1�vjBY�J#       ��wC	�� 5yO�A�*

train_loss_16sjB%�g"#       ��wC	� 5yO�A�*

train_loss_1�ojBqH�#       ��wC	�� 5yO�A�*

train_loss_12ljB�@#       ��wC	�!5yO�A�*

train_loss_1�hjBPE#       ��wC	g!5yO�A�*

train_loss_11ejB�y��#       ��wC	�!5yO�A�*

train_loss_1�ajB��
h#       ��wC	#!5yO�A�*

train_loss_11^jBF��#       ��wC	=+!5yO�A�*

train_loss_1�ZjB٩ݏ#       ��wC	�3!5yO�A�*

train_loss_16WjB^�]#       ��wC	!;!5yO�A�*

train_loss_1�SjBU�#       ��wC	�A!5yO�A�*

train_loss_1>PjBA:?#       ��wC	(I!5yO�A�*

train_loss_1�LjB���p#       ��wC	�O!5yO�A�*

train_loss_1JIjB�Of#       ��wC	mV!5yO�A�*

train_loss_1�EjB�}G#       ��wC	\!5yO�A�*

train_loss_1YBjB��~{#       ��wC	Zb!5yO�A�*

train_loss_1�>jBSΜ�#       ��wC	�h!5yO�A�*

train_loss_1k;jB<�#       ��wC	;o!5yO�A�*

train_loss_1�7jBNlr�#       ��wC	:x!5yO�A�*

train_loss_1�4jB�t�M#       ��wC	�!5yO�A�*

train_loss_11jB�-�r#       ��wC	?�!5yO�A�*

train_loss_1�-jB���#       ��wC	%�!5yO�A�*

train_loss_1&*jBӆ@#       ��wC	̜!5yO�A�*

train_loss_1�&jB��*#       ��wC	M�!5yO�A�*

train_loss_1C#jB��"G#       ��wC	��!5yO�A�*

train_loss_1�jB�7��#       ��wC	O�!5yO�A�*

train_loss_1djB'�8@#       ��wC	ķ!5yO�A�*

train_loss_1�jB�R�#       ��wC	M�!5yO�A�*

train_loss_1�jB��ƹ#       ��wC	��!5yO�A�*

train_loss_1jB���#       ��wC	��!5yO�A�*

train_loss_1�jB�v�#       ��wC	�!5yO�A�*

train_loss_1FjB�O�:#       ��wC	��!5yO�A�*

train_loss_1�jBA���#       ��wC	��!5yO�A�*

train_loss_1pjBW�#       ��wC	u�!5yO�A�*

train_loss_1jB�Q.#       ��wC	��!5yO�A�*

train_loss_1��iB��HN#       ��wC	��!5yO�A�*

train_loss_1;�iBգc�#       ��wC	h"5yO�A�*

train_loss_1��iB,�?�#       ��wC	�"5yO�A�*

train_loss_1l�iB�P0�#       ��wC	N"5yO�A�*

train_loss_1�iBRU�\#       ��wC	{"5yO�A�*

train_loss_1��iB�>��#       ��wC	�#"5yO�A�*

train_loss_1B�iBW}�#       ��wC	�."5yO�A�*

train_loss_1��iB`л|#       ��wC	C8"5yO�A�*

train_loss_1{�iB�M#       ��wC	�@"5yO�A�*

train_loss_1�iB�#       ��wC	wG"5yO�A�*

train_loss_1��iB�y�;#       ��wC	N"5yO�A�*

train_loss_1\�iB	�Gu#       ��wC	�T"5yO�A�*

train_loss_1��iBr0��#       ��wC	�["5yO�A�*

train_loss_1��iBf�T$#       ��wC	b"5yO�A�*

train_loss_1B�iB�W�#       ��wC	�h"5yO�A�*

train_loss_1��iB�x��#       ��wC	�n"5yO�A�*

train_loss_1��iB%��s#       ��wC	�t"5yO�A�*

train_loss_1.�iB=-��#       ��wC	_{"5yO�A�*

train_loss_1��iB2�;�#       ��wC	��"5yO�A�*

train_loss_1|�iB��ב#       ��wC	�"5yO�A�*

train_loss_1"�iB��Q#       ��wC	T�"5yO�A�*

train_loss_1ʶiB�;P#       ��wC	��"5yO�A�*

train_loss_1r�iB�ೄ#       ��wC	��"5yO�A�*

train_loss_1�iB�pF�#       ��wC	@�"5yO�A�*

train_loss_1ǬiBW�F#       ��wC	Ҩ"5yO�A�*

train_loss_1s�iB�2�#       ��wC	֮"5yO�A�*

train_loss_1�iB�ћB#       ��wC	��"5yO�A�*

train_loss_1ˢiB�ҩ#       ��wC	��"5yO�A�*

train_loss_1x�iBfK�s#       ��wC	��"5yO�A�*

train_loss_1'�iB�6R�#       ��wC	��"5yO�A�*

train_loss_1ؘiBe��#       ��wC	��"5yO�A�*

train_loss_1��iB�Y�C#       ��wC	��"5yO�A�*

train_loss_17�iB�!�#       ��wC	��"5yO�A�*

train_loss_1�iB�4F#       ��wC	��"5yO�A�*

train_loss_1��iB FW#       ��wC	>#5yO�A�*

train_loss_1L�iB|r2#       ��wC	�#5yO�A�*

train_loss_1 �iBZ<�#       ��wC	#5yO�A�*

train_loss_1��iB�'��#       ��wC	�%#5yO�A�*

train_loss_1i~iB���#       ��wC	w,#5yO�A�*

train_loss_1{iB�.�#       ��wC	�2#5yO�A�*

train_loss_1�wiB,B�m#       ��wC	�8#5yO�A�*

train_loss_1�tiB;A��#       ��wC	�?#5yO�A�*

train_loss_1BqiB�:�g#       ��wC	�F#5yO�A�*

train_loss_1�miBoAa>#       ��wC	�N#5yO�A�*

train_loss_1�jiB�L�`#       ��wC	rU#5yO�A�*

train_loss_1ogiB�/|	#       ��wC	�]#5yO�A�*

train_loss_1)diBЎ.�#       ��wC	�f#5yO�A�*

train_loss_1�`iB���#       ��wC	�r#5yO�A�*

train_loss_1�]iB9p#       ��wC	�|#5yO�A�*

train_loss_1^ZiB��߃#       ��wC	j�#5yO�A�*

train_loss_1WiBM�2#
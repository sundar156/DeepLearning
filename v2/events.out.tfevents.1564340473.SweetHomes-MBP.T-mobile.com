       �K"	  @>|O�Abrain.Event:2� ں�=      �dR�	�^>|O�A"�{
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
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*
	keep_dims(*

Tidx0*
T0*'
_output_shapes
:���������
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
MatMulMatMull2_normalizeVariable/read*'
_output_shapes
:���������*
transpose_a( *
transpose_b( *
T0
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
gradients/Loss_grad/Const_1Const*
dtype0*
_output_shapes
:*
valueB: 
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
gradients/Loss_grad/MaximumMaximumgradients/Loss_grad/Prod_1gradients/Loss_grad/Maximum/y*
_output_shapes
: *
T0
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
gradients/sub_grad/Sum_1Sumgradients/Square_grad/Mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
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
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
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
shape: *
dtype0*
_output_shapes
: 
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
Variable_1save/RestoreV2:1*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*
_class
loc:@Variable_1
6
save/restore_allNoOp^save/Assign^save/Assign_1
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
init_2NoOp^Variable/Assign^Variable_1/Assign
[
save_1/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
r
save_1/filenamePlaceholderWithDefaultsave_1/filename/input*
dtype0*
_output_shapes
: *
shape: 
i
save_1/ConstPlaceholderWithDefaultsave_1/filename*
dtype0*
_output_shapes
: *
shape: 
w
save_1/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
i
save_1/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
�
save_1/SaveV2SaveV2save_1/Constsave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
�
save_1/control_dependencyIdentitysave_1/Const^save_1/SaveV2*
T0*
_class
loc:@save_1/Const*
_output_shapes
: 
�
save_1/RestoreV2/tensor_namesConst"/device:CPU:0*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
{
!save_1/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B 
�
save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices"/device:CPU:0*
_output_shapes

::*
dtypes
2
�
save_1/AssignAssignVariablesave_1/RestoreV2*
use_locking(*
T0*
_class
loc:@Variable*
validate_shape(*
_output_shapes

:
�
save_1/Assign_1Assign
Variable_1save_1/RestoreV2:1*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*
_class
loc:@Variable_1
<
save_1/restore_allNoOp^save_1/Assign^save_1/Assign_1
^
train_loss_2/tagsConst*
valueB Btrain_loss_2*
dtype0*
_output_shapes
: 
W
train_loss_2ScalarSummarytrain_loss_2/tagsLoss*
_output_shapes
: *
T0
4
init_3NoOp^Variable/Assign^Variable_1/Assign
[
save_2/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
r
save_2/filenamePlaceholderWithDefaultsave_2/filename/input*
dtype0*
_output_shapes
: *
shape: 
i
save_2/ConstPlaceholderWithDefaultsave_2/filename*
dtype0*
_output_shapes
: *
shape: 
w
save_2/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
i
save_2/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
�
save_2/SaveV2SaveV2save_2/Constsave_2/SaveV2/tensor_namessave_2/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
�
save_2/control_dependencyIdentitysave_2/Const^save_2/SaveV2*
T0*
_class
loc:@save_2/Const*
_output_shapes
: 
�
save_2/RestoreV2/tensor_namesConst"/device:CPU:0*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
{
!save_2/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B *
dtype0*
_output_shapes
:
�
save_2/RestoreV2	RestoreV2save_2/Constsave_2/RestoreV2/tensor_names!save_2/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::
�
save_2/AssignAssignVariablesave_2/RestoreV2*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class
loc:@Variable
�
save_2/Assign_1Assign
Variable_1save_2/RestoreV2:1*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:*
use_locking(
<
save_2/restore_allNoOp^save_2/Assign^save_2/Assign_1"\eI      e���	�o_>|O�AJ��
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
shared_namestring �*1.13.12b'v1.13.0-rc2-5-g6612da8951'�{
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
l2_normalize/SumSuml2_normalize/Square"l2_normalize/Sum/reduction_indices*

Tidx0*
	keep_dims(*
T0*'
_output_shapes
:���������
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
l2_normalize/RsqrtRsqrtl2_normalize/Maximum*'
_output_shapes
:���������*
T0
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
gradients/Loss_grad/ShapeShapeSquare*
_output_shapes
:*
T0*
out_type0
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
gradients/Loss_grad/Prod_1Prodgradients/Loss_grad/Shape_2gradients/Loss_grad/Const_1*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
_
gradients/Loss_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
�
gradients/Loss_grad/MaximumMaximumgradients/Loss_grad/Prod_1gradients/Loss_grad/Maximum/y*
_output_shapes
: *
T0
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
gradients/sub_grad/ShapeShapeoutput*
_output_shapes
:*
T0*
out_type0
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
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*

Tidx0*
	keep_dims( *
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
transpose_b( *
T0*
transpose_a(*
_output_shapes

:
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
shape: *
dtype0*
_output_shapes
: 
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
save/restore_allNoOp^save/Assign^save/Assign_1
^
train_loss_1/tagsConst*
dtype0*
_output_shapes
: *
valueB Btrain_loss_1
W
train_loss_1ScalarSummarytrain_loss_1/tagsLoss*
T0*
_output_shapes
: 
4
init_2NoOp^Variable/Assign^Variable_1/Assign
[
save_1/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
r
save_1/filenamePlaceholderWithDefaultsave_1/filename/input*
dtype0*
_output_shapes
: *
shape: 
i
save_1/ConstPlaceholderWithDefaultsave_1/filename*
dtype0*
_output_shapes
: *
shape: 
w
save_1/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*)
value BBVariableB
Variable_1
i
save_1/SaveV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueBB B 
�
save_1/SaveV2SaveV2save_1/Constsave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
�
save_1/control_dependencyIdentitysave_1/Const^save_1/SaveV2*
T0*
_class
loc:@save_1/Const*
_output_shapes
: 
�
save_1/RestoreV2/tensor_namesConst"/device:CPU:0*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
{
!save_1/RestoreV2/shape_and_slicesConst"/device:CPU:0*
valueBB B *
dtype0*
_output_shapes
:
�
save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::
�
save_1/AssignAssignVariablesave_1/RestoreV2*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class
loc:@Variable
�
save_1/Assign_1Assign
Variable_1save_1/RestoreV2:1*
validate_shape(*
_output_shapes
:*
use_locking(*
T0*
_class
loc:@Variable_1
<
save_1/restore_allNoOp^save_1/Assign^save_1/Assign_1
^
train_loss_2/tagsConst*
dtype0*
_output_shapes
: *
valueB Btrain_loss_2
W
train_loss_2ScalarSummarytrain_loss_2/tagsLoss*
T0*
_output_shapes
: 
4
init_3NoOp^Variable/Assign^Variable_1/Assign
[
save_2/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
r
save_2/filenamePlaceholderWithDefaultsave_2/filename/input*
dtype0*
_output_shapes
: *
shape: 
i
save_2/ConstPlaceholderWithDefaultsave_2/filename*
dtype0*
_output_shapes
: *
shape: 
w
save_2/SaveV2/tensor_namesConst*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
i
save_2/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
�
save_2/SaveV2SaveV2save_2/Constsave_2/SaveV2/tensor_namessave_2/SaveV2/shape_and_slicesVariable
Variable_1*
dtypes
2
�
save_2/control_dependencyIdentitysave_2/Const^save_2/SaveV2*
T0*
_class
loc:@save_2/Const*
_output_shapes
: 
�
save_2/RestoreV2/tensor_namesConst"/device:CPU:0*)
value BBVariableB
Variable_1*
dtype0*
_output_shapes
:
{
!save_2/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B 
�
save_2/RestoreV2	RestoreV2save_2/Constsave_2/RestoreV2/tensor_names!save_2/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::
�
save_2/AssignAssignVariablesave_2/RestoreV2*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class
loc:@Variable
�
save_2/Assign_1Assign
Variable_1save_2/RestoreV2:1*
use_locking(*
T0*
_class
loc:@Variable_1*
validate_shape(*
_output_shapes
:
<
save_2/restore_allNoOp^save_2/Assign^save_2/Assign_1""
train_op

GradientDescent"�
	variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08"=
	summaries0
.
train_loss:0
train_loss_1:0
train_loss_2:0"�
trainable_variables}
;

Variable:0Variable/AssignVariable/read:02	Weights:08
>
Variable_1:0Variable_1/AssignVariable_1/read:02Bias:08�e�        )��P	��`>|O�A*

train_loss_2g	Dk��"       x=�	 b>|O�A*

train_loss_2v��Bǯ�"       x=�	0+b>|O�A*

train_loss_2ТB�Tml"       x=�	4b>|O�A*

train_loss_2���B�ґ�"       x=�	2=b>|O�A*

train_loss_2��B�"       x=�	^Gb>|O�A*

train_loss_2�o�B���L"       x=�	DPb>|O�A*

train_loss_2��B�zw�"       x=�	�Xb>|O�A*

train_loss_2ڽ�B
|Z9"       x=�	ab>|O�A*

train_loss_2�~�BV�d�"       x=�	�jb>|O�A	*

train_loss_2P�B�5[�"       x=�	qtb>|O�A
*

train_loss_2�0�B�z_�"       x=�	~b>|O�A*

train_loss_2n�B/c^"       x=�	U�b>|O�A*

train_loss_2�B��"       x=�	ِb>|O�A*

train_loss_2�%�B$�8"       x=�	5�b>|O�A*

train_loss_2�;�Bߏ_�"       x=�	/�b>|O�A*

train_loss_2s]�B��k�"       x=�	��b>|O�A*

train_loss_2L��B)V��"       x=�	��b>|O�A*

train_loss_2���BL�`�"       x=�	��b>|O�A*

train_loss_2�B��]�"       x=�	��b>|O�A*

train_loss_2�M�B�ՙ("       x=�	��b>|O�A*

train_loss_2ܡ�B�)�7"       x=�	��b>|O�A*

train_loss_2I��B��+�"       x=�	��b>|O�A*

train_loss_2�b�B��j�"       x=�	,�b>|O�A*

train_loss_2ϊBط$"       x=�	D�b>|O�A*

train_loss_2�B�BJ�9�"       x=�	& c>|O�A*

train_loss_2���Bҡ/�"       x=�	}c>|O�A*

train_loss_2�=�B��ƕ"       x=�	�c>|O�A*

train_loss_2$ňB�en"       x=�	
c>|O�A*

train_loss_2AR�B�넍"       x=�	�c>|O�A*

train_loss_2��B2��|"       x=�	� c>|O�A*

train_loss_2�|�B(���"       x=�	4(c>|O�A*

train_loss_2�BB��"       x=�	'1c>|O�A *

train_loss_2廆B����"       x=�	P9c>|O�A!*

train_loss_2Gb�B�*n�"       x=�	G@c>|O�A"*

train_loss_2��B��J"       x=�	�Fc>|O�A#*

train_loss_2���B����"       x=�	�Nc>|O�A$*

train_loss_2`n�B98x"       x=�	�Uc>|O�A%*

train_loss_2�$�B���="       x=�	>\c>|O�A&*

train_loss_2ބB���L"       x=�	�bc>|O�A'*

train_loss_2���Bb��"       x=�	4jc>|O�A(*

train_loss_2�[�B6X�"       x=�	�pc>|O�A)*

train_loss_2�B)��"       x=�	.wc>|O�A**

train_loss_2#�B`�%"       x=�	V}c>|O�A+*

train_loss_2ݭ�B$͎^"       x=�	Ãc>|O�A,*

train_loss_2"y�B�VTf"       x=�	&�c>|O�A-*

train_loss_2�F�B�1��"       x=�	T�c>|O�A.*

train_loss_2��B0�="       x=�	��c>|O�A/*

train_loss_2��B,��"       x=�	ǜc>|O�A0*

train_loss_2'��B/�k"       x=�	Ӣc>|O�A1*

train_loss_2P��B��7@"       x=�	�c>|O�A2*

train_loss_2Sk�B���"       x=�	��c>|O�A3*

train_loss_2E�B����"       x=�	��c>|O�A4*

train_loss_2� �Be�/�"       x=�		�c>|O�A5*

train_loss_2���B,�1�"       x=�	m�c>|O�A6*

train_loss_2܁BN��"       x=�	�c>|O�A7*

train_loss_2��BET;"       x=�	=�c>|O�A8*

train_loss_2d��BI��"       x=�	��c>|O�A9*

train_loss_2��BS�y"       x=�	��c>|O�A:*

train_loss_2�c�B�;oO"       x=�	J�c>|O�A;*

train_loss_2�H�Bk��O"       x=�	��c>|O�A<*

train_loss_2�.�B��"       x=�	2d>|O�A=*

train_loss_2��B�7��"       x=�	�	d>|O�A>*

train_loss_2��B�W�"       x=�	gd>|O�A?*

train_loss_2#�B��j{"       x=�	�d>|O�A@*

train_loss_2рB��n�"       x=�	�d>|O�AA*

train_loss_2ܻ�B<#�"       x=�	6%d>|O�AB*

train_loss_2r��B^5"       x=�	�,d>|O�AC*

train_loss_2˓�B�(�0"       x=�	n4d>|O�AD*

train_loss_2ހ�Bb�_	"       x=�	�;d>|O�AE*

train_loss_2�n�B�P�"       x=�	 Bd>|O�AF*

train_loss_2
]�B�W�"       x=�	�Hd>|O�AG*

train_loss_2L�B�M��"       x=�	�Nd>|O�AH*

train_loss_2�;�B�o�"       x=�	mUd>|O�AI*

train_loss_2�+�B���"       x=�	�[d>|O�AJ*

train_loss_2��BqF��"       x=�	�bd>|O�AK*

train_loss_2��BѢ��"       x=�	id>|O�AL*

train_loss_2��B҃�"       x=�	�od>|O�AM*

train_loss_23�B.*�"       x=�	�ud>|O�AN*

train_loss_2U�B���s"       x=�	1|d>|O�AO*

train_loss_2M�B�b��"       x=�	ǂd>|O�AP*

train_loss_2�B�fo�"       x=�	?�d>|O�AQ*

train_loss_2�|Bѩ�e"       x=�	��d>|O�AR*

train_loss_2�dB~���"       x=�	��d>|O�AS*

train_loss_2�MB4���"       x=�	ԛd>|O�AT*

train_loss_2 7B��M�"       x=�	ǡd>|O�AU*

train_loss_2!BUR�"       x=�	��d>|O�AV*

train_loss_2�B�&H�"       x=�	)�d>|O�AW*

train_loss_2��~B�t��"       x=�	��d>|O�AX*

train_loss_2��~B���"       x=�	r�d>|O�AY*

train_loss_2��~B����"       x=�	�d>|O�AZ*

train_loss_2��~BP��"       x=�	��d>|O�A[*

train_loss_2��~Bڪ["       x=�	��d>|O�A\*

train_loss_2'�~B���D"       x=�	��d>|O�A]*

train_loss_2�~B�4�"       x=�	��d>|O�A^*

train_loss_2gr~B]� �"       x=�	F�d>|O�A_*

train_loss_2a~B�,"       x=�	I�d>|O�A`*

train_loss_2P~B��"       x=�	j�d>|O�Aa*

train_loss_2t?~Bq�k"       x=�	e>|O�Ab*

train_loss_2/~BP�#/"       x=�	�e>|O�Ac*

train_loss_2~B�<�"       x=�	5e>|O�Ad*

train_loss_2T~B��,"       x=�	��e>|O�Ae*

train_loss_2��}B�aPU"       x=�	��e>|O�Af*

train_loss_2��}B}b�"       x=�	D�e>|O�Ag*

train_loss_2��}B���"       x=�	!f>|O�Ah*

train_loss_2��}B+�)"       x=�	�
f>|O�Ai*

train_loss_2]�}B��N"       x=�	�f>|O�Aj*

train_loss_2�}BuX�"       x=�	�f>|O�Ak*

train_loss_2�}B8�R"       x=�	"f>|O�Al*

train_loss_2�}B�l�o"       x=�	(*f>|O�Am*

train_loss_2H�}BU@�"       x=�	�2f>|O�An*

train_loss_2�~}B���z"       x=�	�>f>|O�Ao*

train_loss_2Qq}B�)3�"       x=�	VKf>|O�Ap*

train_loss_2d}B;�9�"       x=�	Xf>|O�Aq*

train_loss_2 W}Bw��"       x=�	�`f>|O�Ar*

train_loss_2J}B:*D"       x=�	�lf>|O�As*

train_loss_2B=}Bg�׏"       x=�	}vf>|O�At*

train_loss_2�0}B��P"       x=�	�f>|O�Au*

train_loss_2$}B���j"       x=�	��f>|O�Av*

train_loss_2�}B+D�I"       x=�	]�f>|O�Aw*

train_loss_2Q}B��fV"       x=�	\�f>|O�Ax*

train_loss_2 �|Bd�I"       x=�	��f>|O�Ay*

train_loss_2	�|B�x�"       x=�	��f>|O�Az*

train_loss_2�|B��D"       x=�	�f>|O�A{*

train_loss_2)�|B/SK"       x=�	d�f>|O�A|*

train_loss_2]�|B$�h�"       x=�	��f>|O�A}*

train_loss_2��|Bq�="       x=�	8�f>|O�A~*

train_loss_2�|B�qvT"       x=�	?�f>|O�A*

train_loss_2��|B����#       ��wC	��f>|O�A�*

train_loss_2
�|B��2�#       ��wC	^�f>|O�A�*

train_loss_2��|B#�5�#       ��wC	��f>|O�A�*

train_loss_2Z�|B̬�#       ��wC	�f>|O�A�*

train_loss_2|B?�D
#       ��wC	i�f>|O�A�*

train_loss_2�s|B֘�1#       ��wC	t�f>|O�A�*

train_loss_2�h|Bؕ"X#       ��wC	��f>|O�A�*

train_loss_2�]|BwR�g#       ��wC	z�f>|O�A�*

train_loss_2�R|B��{#       ��wC	��f>|O�A�*

train_loss_2�G|B>=�#       ��wC	�g>|O�A�*

train_loss_2 =|B����#       ��wC	�g>|O�A�*

train_loss_2/2|B�F�#       ��wC	�g>|O�A�*

train_loss_2i'|Bq�{#       ��wC	]g>|O�A�*

train_loss_2�|B!���#       ��wC	�g>|O�A�*

train_loss_2|B	_q#       ��wC	�&g>|O�A�*

train_loss_2i|BP� l#       ��wC	b.g>|O�A�*

train_loss_2��{BaP�+#       ��wC	�4g>|O�A�*

train_loss_2P�{Br(V#       ��wC	�:g>|O�A�*

train_loss_2��{B�vW�#       ��wC	-Ag>|O�A�*

train_loss_2_�{B39��#       ��wC	�Hg>|O�A�*

train_loss_2��{B��P9#       ��wC	Pg>|O�A�*

train_loss_2��{B~��#       ��wC	�Vg>|O�A�*

train_loss_2F�{B��#       ��wC	�]g>|O�A�*

train_loss_2��{Br�i�#       ��wC	�eg>|O�A�*

train_loss_2��{B3K��#       ��wC	@lg>|O�A�*

train_loss_2��{B��E#       ��wC	hrg>|O�A�*

train_loss_2R�{B���#       ��wC	�xg>|O�A�*

train_loss_2(�{B&��c#       ��wC	�~g>|O�A�*

train_loss_2
�{BI�Fo#       ��wC	��g>|O�A�*

train_loss_2�v{Bo@2#       ��wC	��g>|O�A�*

train_loss_2�l{B�R�#       ��wC	q�g>|O�A�*

train_loss_2�b{BH���#       ��wC	��g>|O�A�*

train_loss_2�X{BrXZ�#       ��wC	�g>|O�A�*

train_loss_2�N{By�ԇ#       ��wC	v�g>|O�A�*

train_loss_2�D{B����#       ��wC	\�g>|O�A�*

train_loss_2;{B����#       ��wC	F�g>|O�A�*

train_loss_2"1{BH�n)#       ��wC	R�g>|O�A�*

train_loss_2E'{B6g{f#       ��wC	��g>|O�A�*

train_loss_2l{B�$:#       ��wC	�g>|O�A�*

train_loss_2�{B0�z�#       ��wC	��g>|O�A�*

train_loss_2�	{B�/3#       ��wC	=�g>|O�A�*

train_loss_2 {B�v�=#       ��wC	��g>|O�A�*

train_loss_2V�zB���#       ��wC	�g>|O�A�*

train_loss_2��zB);>w#       ��wC	O�g>|O�A�*

train_loss_2��zBn�@#       ��wC	��g>|O�A�*

train_loss_2E�zB<��#       ��wC	8�g>|O�A�*

train_loss_2��zB�w�#       ��wC	��g>|O�A�*

train_loss_2 �zB4�:#       ��wC	��g>|O�A�*

train_loss_2d�zBE�#       ��wC	h>|O�A�*

train_loss_2вzBi���#       ��wC	4h>|O�A�*

train_loss_2D�zB�I�Q#       ��wC	<h>|O�A�*

train_loss_2��zB�n�G#       ��wC	8h>|O�A�*

train_loss_25�zB�eP�#       ��wC	6h>|O�A�*

train_loss_2��zB�g0�#       ��wC	$h>|O�A�*

train_loss_2>�zB����#       ��wC	M*h>|O�A�*

train_loss_2�yzB �<�#       ��wC	30h>|O�A�*

train_loss_2ZpzB$C�#       ��wC	P6h>|O�A�*

train_loss_2�fzB�t_c#       ��wC	�<h>|O�A�*

train_loss_2�]zB=���#       ��wC	Dh>|O�A�*

train_loss_2*TzB�e��#       ��wC	Kh>|O�A�*

train_loss_2�JzB@���#       ��wC	�Rh>|O�A�*

train_loss_2yAzB��,#       ��wC	�Zh>|O�A�*

train_loss_2'8zB����#       ��wC	9ah>|O�A�*

train_loss_2�.zB�&�#       ��wC	@gh>|O�A�*

train_loss_2�%zB�>ZV#       ��wC	�mh>|O�A�*

train_loss_2OzBvSI#       ��wC	�th>|O�A�*

train_loss_2zB���:#       ��wC	�{h>|O�A�*

train_loss_2�	zB��W�#       ��wC	��h>|O�A�*

train_loss_2� zB|�N#       ��wC	f�h>|O�A�*

train_loss_2q�yB9�Yb#       ��wC	d�h>|O�A�*

train_loss_2F�yB�T�)#       ��wC	h�h>|O�A�*

train_loss_2�yB��#       ��wC	��h>|O�A�*

train_loss_2��yB2��1#       ��wC	Ơh>|O�A�*

train_loss_2��yB-��}#       ��wC	�qi>|O�A�*

train_loss_2��yB:�M3#       ��wC	{i>|O�A�*

train_loss_2��yB�11#       ��wC	^�i>|O�A�*

train_loss_2��yBBL�!#       ��wC	n�i>|O�A�*

train_loss_2��yBw�T#       ��wC	L�i>|O�A�*

train_loss_2��yB�O#       ��wC	�i>|O�A�*

train_loss_2�yB����#       ��wC	<�i>|O�A�*

train_loss_2��yB�ƴ#       ��wC	C�i>|O�A�*

train_loss_2��yB1Ԃ#       ��wC	 �i>|O�A�*

train_loss_2��yB!G�#       ��wC	��i>|O�A�*

train_loss_2�xyB�c.#       ��wC	\�i>|O�A�*

train_loss_2�oyB�4�#       ��wC	�i>|O�A�*

train_loss_2�fyB�Q�)#       ��wC	/�i>|O�A�*

train_loss_2�]yB�9#       ��wC	z�i>|O�A�*

train_loss_2�TyB+�o�#       ��wC	,�i>|O�A�*

train_loss_2LyBo���#       ��wC	��i>|O�A�*

train_loss_2;CyBBm�f#       ��wC	j>|O�A�*

train_loss_2e:yB�ĭm#       ��wC	�j>|O�A�*

train_loss_2�1yB�
�\#       ��wC	K!j>|O�A�*

train_loss_2�(yBH��7#       ��wC	�(j>|O�A�*

train_loss_2�yB�V3p#       ��wC	/j>|O�A�*

train_loss_25yB��C#       ��wC	�5j>|O�A�*

train_loss_2pyB��U#       ��wC	L<j>|O�A�*

train_loss_2�yB�.�c#       ��wC	�Cj>|O�A�*

train_loss_2��xBB�fl#       ��wC	�Ij>|O�A�*

train_loss_2B�xB�m�E#       ��wC	rPj>|O�A�*

train_loss_2��xB%d�w#       ��wC	�Vj>|O�A�*

train_loss_2��xBa��#       ��wC	]j>|O�A�*

train_loss_27�xB��|a#       ��wC	{fj>|O�A�*

train_loss_2��xBDoi�#       ��wC	�oj>|O�A�*

train_loss_2��xBȾ��#       ��wC	}wj>|O�A�*

train_loss_2N�xBO��S#       ��wC	j>|O�A�*

train_loss_2��xB?%#       ��wC	'�j>|O�A�*

train_loss_2�xB��2�#       ��wC	i�j>|O�A�*

train_loss_2��xB��l#       ��wC	O�j>|O�A�*

train_loss_2��xBQ�i#       ��wC	��j>|O�A�*

train_loss_2l�xB���#       ��wC	V�j>|O�A�*

train_loss_2�xB�J�#       ��wC	��j>|O�A�*

train_loss_2`�xB+��M#       ��wC	X�j>|O�A�*

train_loss_2�{xB�	��#       ��wC	 �j>|O�A�*

train_loss_2esxB�<�#       ��wC	��j>|O�A�*

train_loss_2�jxBX��#       ��wC	P�j>|O�A�*

train_loss_2wbxBK5��#       ��wC	O�j>|O�A�*

train_loss_2ZxB�t��#       ��wC	��j>|O�A�*

train_loss_2�QxB(m_#       ��wC	��j>|O�A�*

train_loss_20IxB�Wj#       ��wC	U�j>|O�A�*

train_loss_2�@xB��_Y#       ��wC	��j>|O�A�*

train_loss_2g8xB}~�;#       ��wC	k�j>|O�A�*

train_loss_20xB�Z��#       ��wC	^�j>|O�A�*

train_loss_2�'xB,׍?#       ��wC	��j>|O�A�*

train_loss_2TxBx##       ��wC	�
k>|O�A�*

train_loss_2�xBw	F#       ��wC	Hk>|O�A�*

train_loss_2�xB��yi#       ��wC	�*k>|O�A�*

train_loss_2exB;�X##       ��wC	e:k>|O�A�*

train_loss_2�wBA*Y#       ��wC	�Kk>|O�A�*

train_loss_2��wB'�3#       ��wC	�[k>|O�A�*

train_loss_2��wB޿N�#       ��wC	�ok>|O�A�*

train_loss_2V�wB�O�#       ��wC	V�k>|O�A�*

train_loss_2�wB��k#       ��wC	ōk>|O�A�*

train_loss_2��wB���#       ��wC	�k>|O�A�*

train_loss_2��wB�M1�#       ��wC	��k>|O�A�*

train_loss_2��wB�|#       ��wC	��k>|O�A�*

train_loss_2Z�wB��$#       ��wC	I�k>|O�A�*

train_loss_21�wB��h`#       ��wC	��k>|O�A�*

train_loss_2
�wB��~�#       ��wC	x�k>|O�A�*

train_loss_2�wB�hq�#       ��wC	��k>|O�A�*

train_loss_2˛wB��'�#       ��wC	�k>|O�A�*

train_loss_2��wBp�#       ��wC	8�k>|O�A�*

train_loss_2��wB���L#       ��wC	�l>|O�A�*

train_loss_2��wB/e�#       ��wC	�l>|O�A�*

train_loss_2x{wB�#       ��wC	�l>|O�A�*

train_loss_2kswB�D9#       ��wC	B%l>|O�A�*

train_loss_2dkwB���!#       ��wC	=/l>|O�A�*

train_loss_2]cwB̵R#       ��wC	�:l>|O�A�*

train_loss_2Z[wB�HN�#       ��wC	�El>|O�A�*

train_loss_2]SwBN¡|#       ��wC	fPl>|O�A�*

train_loss_2aKwB��#       ��wC	C[l>|O�A�*

train_loss_2kCwB*�	#       ��wC	�il>|O�A�*

train_loss_2u;wB��L#       ��wC	1|l>|O�A�*

train_loss_2�3wB�<#       ��wC	ϊl>|O�A�*

train_loss_2�+wB&�*#       ��wC	,�l>|O�A�*

train_loss_2�#wB���#       ��wC	U�l>|O�A�*

train_loss_2�wB��D#       ��wC	:�l>|O�A�*

train_loss_2�wB7JOF#       ��wC	��l>|O�A�*

train_loss_2wB����#       ��wC	w�l>|O�A�*

train_loss_2)wB�gh�#       ��wC	)�l>|O�A�*

train_loss_2O�vB�'�#       ��wC	��l>|O�A�*

train_loss_2z�vBI�C�#       ��wC	�l>|O�A�*

train_loss_2��vB���#       ��wC	��l>|O�A�*

train_loss_2��vB���/#       ��wC	��l>|O�A�*

train_loss_2�vBāe�#       ��wC	r�l>|O�A�*

train_loss_2D�vB��#       ��wC	>m>|O�A�*

train_loss_2��vB��#       ��wC	km>|O�A�*

train_loss_2��vBؾ~�#       ��wC	�m>|O�A�*

train_loss_2��vB��#       ��wC	�&m>|O�A�*

train_loss_2F�vB4\�k#       ��wC	1m>|O�A�*

train_loss_2��vBl�;#       ��wC	�:m>|O�A�*

train_loss_2ئvB�PE�#       ��wC	FCm>|O�A�*

train_loss_2%�vB��.�#       ��wC	�Mm>|O�A�*

train_loss_2x�vB`K3�#       ��wC	�Ym>|O�A�*

train_loss_2̏vBy:�n#       ��wC	k�n>|O�A�*

train_loss_2%�vB�w'H#       ��wC	,�n>|O�A�*

train_loss_2��vB
��v#       ��wC	��n>|O�A�*

train_loss_2�xvBFYa�#       ��wC	D�n>|O�A�*

train_loss_2CqvB��Ӳ#       ��wC	_�n>|O�A�*

train_loss_2�ivB�rp#       ��wC	i�n>|O�A�*

train_loss_2bvB�\��#       ��wC	�o>|O�A�*

train_loss_2yZvB�5`#       ��wC	�&o>|O�A�*

train_loss_2�RvB�R�#       ��wC	&6o>|O�A�*

train_loss_2[KvBP��#       ��wC	�Co>|O�A�*

train_loss_2�CvB���#       ��wC	#Oo>|O�A�*

train_loss_2H<vB��Џ#       ��wC	]o>|O�A�*

train_loss_2�4vB�hy#       ��wC	"mo>|O�A�*

train_loss_2B-vB9�_#       ��wC	�{o>|O�A�*

train_loss_2�%vBEr#       ��wC	J�o>|O�A�*

train_loss_2JvBH�h�#       ��wC	��o>|O�A�*

train_loss_2�vBݿ`�#       ��wC	<�o>|O�A�*

train_loss_2^vBd64#       ��wC	��o>|O�A�*

train_loss_2�vB��ǚ#       ��wC	"�o>|O�A�*

train_loss_2| vBמ��#       ��wC	�p>|O�A�*

train_loss_2�uBe�a#       ��wC	Lp>|O�A�*

train_loss_2��uB�J��#       ��wC	,$p>|O�A�*

train_loss_2C�uB����#       ��wC	�2p>|O�A�*

train_loss_2��uBK��R#       ��wC	}>p>|O�A�*

train_loss_2��uB���A#       ��wC	�Gp>|O�A�*

train_loss_2%�uBш��#       ��wC	�Qp>|O�A�*

train_loss_2��uBrn#       ��wC	B[p>|O�A�*

train_loss_2w�uB�,�.#       ��wC	^dp>|O�A�*

train_loss_2"�uB�_#       ��wC	znp>|O�A�*

train_loss_2ӶuBx�`~#       ��wC	 wp>|O�A�*

train_loss_2��uB�C�#       ��wC	s�p>|O�A�*

train_loss_2=�uB4�U!#       ��wC	�p>|O�A�*

train_loss_2��uBw<�#       ��wC	�p>|O�A�*

train_loss_2��uBmY�n#       ��wC	r�p>|O�A�*

train_loss_2o�uBif�#       ��wC	!�p>|O�A�*

train_loss_24�uBf�?#       ��wC	кp>|O�A�*

train_loss_2��uB'e�5#       ��wC	X�p>|O�A�*

train_loss_2�|uB��zI#       ��wC	�p>|O�A�*

train_loss_2�uuB��E�#       ��wC	<�p>|O�A�*

train_loss_2XnuB���,#       ��wC	>�p>|O�A�*

train_loss_2(guB�Ť	#       ��wC	��p>|O�A�*

train_loss_2�_uB��&#       ��wC	{�p>|O�A�*

train_loss_2�XuBF�o#       ��wC	yq>|O�A�*

train_loss_2�QuB��#       ��wC	�q>|O�A�*

train_loss_2�JuB��T*#       ��wC	zq>|O�A�*

train_loss_2iCuB��#       ��wC	�q>|O�A�*

train_loss_2M<uBLx�#       ��wC	l&q>|O�A�*

train_loss_235uBu�h`#       ��wC	�-q>|O�A�*

train_loss_2.uB�r�l#       ��wC	.5q>|O�A�*

train_loss_2'uB��B�#       ��wC	�<q>|O�A�*

train_loss_2�uB�F��#       ��wC	�Dq>|O�A�*

train_loss_2�uB�n��#       ��wC	ZLq>|O�A�*

train_loss_2�uB�?�#       ��wC	�Tq>|O�A�*

train_loss_2�
uBR�-2#       ��wC	:\q>|O�A�*

train_loss_2�uBC��m#       ��wC	 dq>|O�A�*

train_loss_2��tBV��#       ��wC	mq>|O�A�*

train_loss_2��tB)Q|�#       ��wC	�tq>|O�A�*

train_loss_2��tB'�3#       ��wC	�|q>|O�A�*

train_loss_2��tB}5��#       ��wC	�q>|O�A�*

train_loss_2��tBɗRa#       ��wC	j�q>|O�A�*

train_loss_2��tB=S�e#       ��wC	�q>|O�A�*

train_loss_2��tB�Ҷ�#       ��wC	��q>|O�A�*

train_loss_2��tB��H#       ��wC	ʦq>|O�A�*

train_loss_2�tBx|��#       ��wC	�q>|O�A�*

train_loss_2#�tB��xU#       ��wC	�q>|O�A�*

train_loss_2<�tBqs�#       ��wC	�q>|O�A�*

train_loss_2V�tB9���#       ��wC	��q>|O�A�*

train_loss_2t�tB(��#       ��wC	d�q>|O�A�*

train_loss_2��tB�L#       ��wC	��q>|O�A�*

train_loss_2��tB쳞�#       ��wC	��q>|O�A�*

train_loss_2�tB�v`#       ��wC	&�q>|O�A�*

train_loss_2
�tB���#       ��wC	��q>|O�A�*

train_loss_27�tB����#       ��wC	��q>|O�A�*

train_loss_2d�tB5]~#       ��wC	�q>|O�A�*

train_loss_2�ytB�Z�=#       ��wC	� r>|O�A�*

train_loss_2�rtB�̙Y#       ��wC	�
r>|O�A�*

train_loss_2ltBS�p#       ��wC	r>|O�A�*

train_loss_2;etB\�Od#       ��wC	vr>|O�A�*

train_loss_2v^tB݃��#       ��wC	�&r>|O�A�*

train_loss_2�WtBʬ��#       ��wC	�0r>|O�A�*

train_loss_2�PtB��G�#       ��wC	�7r>|O�A�*

train_loss_2;JtB��H�#       ��wC	�>r>|O�A�*

train_loss_2�CtBL�l2#       ��wC	�Er>|O�A�*

train_loss_2�<tB/?�#       ��wC	�Mr>|O�A�*

train_loss_26tB2��#       ��wC	CUr>|O�A�*

train_loss_2i/tB:zt[#       ��wC	l]r>|O�A�*

train_loss_2�(tB��&�#       ��wC	�er>|O�A�*

train_loss_2"tB_��#       ��wC	�mr>|O�A�*

train_loss_2dtB	�Q�#       ��wC	�ur>|O�A�*

train_loss_2�tBN-�s#       ��wC	$}r>|O�A�*

train_loss_2tB�,l#       ��wC	Z�r>|O�A�*

train_loss_2ytB��u�#       ��wC	;�r>|O�A�*

train_loss_2� tB�,d#       ��wC	_�r>|O�A�*

train_loss_2?�sB����#       ��wC	��r>|O�A�*

train_loss_2��sB����#       ��wC	��r>|O�A�*

train_loss_2�sB�8'`#       ��wC	��r>|O�A�*

train_loss_2{�sBz��d#       ��wC	$�r>|O�A�*

train_loss_2��sB&��5#       ��wC	�r>|O�A�*

train_loss_2Z�sB����#       ��wC	��r>|O�A�*

train_loss_2��sB"��#       ��wC	��r>|O�A�*

train_loss_2C�sBB�&#       ��wC	�s>|O�A�*

train_loss_2��sB�D5�#       ��wC	��s>|O�A�*

train_loss_2:�sB%���#       ��wC	�s>|O�A�*

train_loss_2��sBU�.�#       ��wC	��s>|O�A�*

train_loss_28�sB��S#       ��wC	3�s>|O�A�*

train_loss_2��sB3��#       ��wC	�s>|O�A�*

train_loss_2@�sB5�8s#       ��wC	��s>|O�A�*

train_loss_2ǞsB��FP#       ��wC	��s>|O�A�*

train_loss_2Q�sBn�#       ��wC	O�s>|O�A�*

train_loss_2ߑsB��.�#       ��wC	�s>|O�A�*

train_loss_2m�sB�tAp#       ��wC	��s>|O�A�*

train_loss_2�sB�0��#       ��wC	��s>|O�A�*

train_loss_2�~sB���>#       ��wC	�t>|O�A�*

train_loss_2-xsB�+�#       ��wC	�	t>|O�A�*

train_loss_2�qsBemp#       ��wC	t>|O�A�*

train_loss_2aksBr�Ћ#       ��wC	rt>|O�A�*

train_loss_2esBq��A#       ��wC	2t>|O�A�*

train_loss_2�^sB񯛌#       ��wC	}"t>|O�A�*

train_loss_2EXsB`5#       ��wC	�(t>|O�A�*

train_loss_2�QsB�6�#       ��wC	�.t>|O�A�*

train_loss_2�KsB�@�#       ��wC	i9t>|O�A�*

train_loss_2>EsBZ9b�#       ��wC	�@t>|O�A�*

train_loss_2�>sB�i�7#       ��wC	�Gt>|O�A�*

train_loss_2�8sB�8�#       ��wC	jOt>|O�A�*

train_loss_2M2sB��f�#       ��wC	�Vt>|O�A�*

train_loss_2,sB)Xώ#       ��wC	]t>|O�A�*

train_loss_2�%sB06��#       ��wC	kct>|O�A�*

train_loss_2usB+7j#       ��wC	fit>|O�A�*

train_loss_2.sB����#       ��wC	�ot>|O�A�*

train_loss_2�sB8���#       ��wC	�vt>|O�A�*

train_loss_2�sB����#       ��wC	}t>|O�A�*

train_loss_2osB��	#       ��wC	�t>|O�A�*

train_loss_25 sB�5_j#       ��wC	�t>|O�A�*

train_loss_2��rB�]�#       ��wC	2�t>|O�A�*

train_loss_2��rB/9ڪ#       ��wC	�t>|O�A�*

train_loss_2��rB�l�#       ��wC	(�t>|O�A�*

train_loss_2c�rB�+|3#       ��wC	��t>|O�A�*

train_loss_25�rB-���#       ��wC	�t>|O�A�*

train_loss_2�rBe�t�#       ��wC	��t>|O�A�*

train_loss_2��rBzw��#       ��wC	$�t>|O�A�*

train_loss_2��rB�{�#       ��wC	��t>|O�A�*

train_loss_2��rB߶h�#       ��wC	�t>|O�A�*

train_loss_2l�rB�/�#       ��wC	��t>|O�A�*

train_loss_2L�rB���#       ��wC	��t>|O�A�*

train_loss_2/�rB�YN#       ��wC	��t>|O�A�*

train_loss_2�rB��eX#       ��wC	��t>|O�A�*

train_loss_2��rB�9��#       ��wC	�t>|O�A�*

train_loss_2�rB�w��#       ��wC	 �t>|O�A�*

train_loss_2̝rB��e#       ��wC	A�t>|O�A�*

train_loss_2��rBÌ�#       ��wC	#�t>|O�A�*

train_loss_2��rB�d�R#       ��wC	3�t>|O�A�*

train_loss_2��rB�/#       ��wC	u>|O�A�*

train_loss_2��rB����#       ��wC	�u>|O�A�*

train_loss_2�rB��̇#       ��wC	�u>|O�A�*

train_loss_2~yrB��U�#       ��wC	�u>|O�A�*

train_loss_2xsrBc�#       ��wC	�u>|O�A�*

train_loss_2umrB6��~#       ��wC	J#u>|O�A�*

train_loss_2tgrBuL#       ��wC	V)u>|O�A�*

train_loss_2uarBQ4�#       ��wC	#/u>|O�A�*

train_loss_2{[rB��? #       ��wC	C5u>|O�A�*

train_loss_2~UrB�AM�#       ��wC	�;u>|O�A�*

train_loss_2�OrB:�+2#       ��wC	�Cu>|O�A�*

train_loss_2�IrBؘ�#       ��wC	sJu>|O�A�*

train_loss_2�CrB��GY#       ��wC	�Pu>|O�A�*

train_loss_2�=rB��P#       ��wC	�Vu>|O�A�*

train_loss_2�7rB��#       ��wC	�\u>|O�A�*

train_loss_2�1rB�G��#       ��wC	cu>|O�A�*

train_loss_2�+rB���q#       ��wC	iu>|O�A�*

train_loss_2 &rB a6#       ��wC	3ou>|O�A�*

train_loss_2 rB6A��#       ��wC	luu>|O�A�*

train_loss_25rB�^�#       ��wC	B{u>|O�A�*

train_loss_2UrB��z#       ��wC	'�u>|O�A�*

train_loss_2trB�O�\#       ��wC	�u>|O�A�*

train_loss_2�rB���Y#       ��wC	�u>|O�A�*

train_loss_2�rB)B��#       ��wC	ٓu>|O�A�*

train_loss_2��qB�wc�#       ��wC	��u>|O�A�*

train_loss_2�qBbb�#       ��wC	��u>|O�A�*

train_loss_2:�qB1O1#       ��wC	L�u>|O�A�*

train_loss_2f�qB
Z�[#       ��wC	��u>|O�A�*

train_loss_2��qB��pb#       ��wC	ܻu>|O�A�*

train_loss_2��qB?G��#       ��wC	T�u>|O�A�*

train_loss_2��qB���Q#       ��wC	��u>|O�A�*

train_loss_21�qB���#       ��wC	��u>|O�A�*

train_loss_2k�qB�w��#       ��wC	��u>|O�A�*

train_loss_2��qB^MJ#       ��wC	��u>|O�A�*

train_loss_2��qB|�W#       ��wC	?v>|O�A�*

train_loss_2�qB���#       ��wC	}v>|O�A�*

train_loss_2`�qB��ɔ#       ��wC	#v>|O�A�*

train_loss_2��qB�F?�#       ��wC	!v>|O�A�*

train_loss_2�qBZވ�#       ��wC	,*v>|O�A�*

train_loss_2/�qB0��#       ��wC	�6v>|O�A�*

train_loss_2x�qB���#       ��wC	�?v>|O�A�*

train_loss_2ĚqB��:�#       ��wC	gJv>|O�A�*

train_loss_2�qB<<1�#       ��wC	GVv>|O�A�*

train_loss_2`�qB���7#       ��wC	�`v>|O�A�*

train_loss_2��qB���3#       ��wC	�jv>|O�A�*

train_loss_2�qB�yh9#       ��wC	�rv>|O�A�*

train_loss_2Z~qBf�#       ��wC	|v>|O�A�*

train_loss_2�xqB��T�#       ��wC	��v>|O�A�*

train_loss_2
sqB�E<#       ��wC	3�v>|O�A�*

train_loss_2gmqBE�4w#       ��wC	�Sw>|O�A�*

train_loss_2�gqB�#z#       ��wC	^w>|O�A�*

train_loss_2#bqB�Xb#       ��wC	Vhw>|O�A�*

train_loss_2�\qB�ץk#       ��wC	�rw>|O�A�*

train_loss_2�VqB�Ə�#       ��wC	��w>|O�A�*

train_loss_2NQqBz%vf#       ��wC	q�w>|O�A�*

train_loss_2�KqB�ô�#       ��wC	��w>|O�A�*

train_loss_2FqB雞V#       ��wC	��w>|O�A�*

train_loss_2�@qB�g9W#       ��wC	[�w>|O�A�*

train_loss_2�:qB�%��#       ��wC	��w>|O�A�*

train_loss_2k5qBxF�#       ��wC	i�w>|O�A�*

train_loss_2�/qBY�-#       ��wC	4�w>|O�A�*

train_loss_2O*qB=#       ��wC	e�w>|O�A�*

train_loss_2�$qBY�5�#       ��wC	��w>|O�A�*

train_loss_2=qB���#       ��wC	k�w>|O�A�*

train_loss_2�qB��?�#       ��wC		�w>|O�A�*

train_loss_23qB���(#       ��wC	yx>|O�A�*

train_loss_2�qBV��S#       ��wC	ox>|O�A�*

train_loss_2/	qB��x6#       ��wC	yx>|O�A�*

train_loss_2�qB�T��#       ��wC	�%x>|O�A�*

train_loss_24�pB,1�_#       ��wC	0x>|O�A�*

train_loss_2��pB��ɽ#       ��wC	�;x>|O�A�*

train_loss_2A�pB�y�#       ��wC	kGx>|O�A�*

train_loss_2��pB��L�#       ��wC	&Sx>|O�A�*

train_loss_2W�pB�#       ��wC	�^x>|O�A�*

train_loss_2��pB��K#       ��wC	@hx>|O�A�*

train_loss_2q�pB�^��#       ��wC	\qx>|O�A�*

train_loss_2�pB=!��#       ��wC	�zx>|O�A�*

train_loss_2��pB�6��#       ��wC	Ãx>|O�A�*

train_loss_2*�pB����#       ��wC	��x>|O�A�*

train_loss_2��pB��m�#       ��wC	��x>|O�A�*

train_loss_2[�pB,Ie(#       ��wC	��x>|O�A�*

train_loss_2��pBY���#       ��wC	?�x>|O�A�*

train_loss_2��pB��ι#       ��wC	��x>|O�A�*

train_loss_20�pBOVbb#       ��wC	�x>|O�A�*

train_loss_2άpBݲ�#       ��wC	�x>|O�A�*

train_loss_2r�pB�	��#       ��wC	:�x>|O�A�*

train_loss_2�pBRLz�#       ��wC	��x>|O�A�*

train_loss_2��pBNN}|#       ��wC	��x>|O�A�*

train_loss_2c�pB�tk#       ��wC	��x>|O�A�*

train_loss_2�pB�@A#       ��wC	��x>|O�A�*

train_loss_2��pBr��#       ��wC	��x>|O�A�*

train_loss_2d�pB?�.;#       ��wC	yy>|O�A�*

train_loss_2�pB�\��#       ��wC	y>|O�A�*

train_loss_2�|pBr�}!#       ��wC	�y>|O�A�*

train_loss_2xwpB���	#       ��wC	�(y>|O�A�*

train_loss_2.rpB�7}#       ��wC	�5y>|O�A�*

train_loss_2�lpBGnv�#       ��wC	lAy>|O�A�*

train_loss_2�gpBj �#       ��wC	�Sy>|O�A�*

train_loss_2VbpBb@ۙ#       ��wC	=by>|O�A�*

train_loss_2]pB>LX?#       ��wC	oy>|O�A�*

train_loss_2�WpBE"�#       ��wC	|y>|O�A�*

train_loss_2�RpB��9f#       ��wC	]�y>|O�A�*

train_loss_2RMpB���(#       ��wC	̗y>|O�A�*

train_loss_2HpBH��:#       ��wC	��y>|O�A�*

train_loss_2�BpByy7�#       ��wC	��y>|O�A�*

train_loss_2�=pB�;�#       ��wC	��y>|O�A�*

train_loss_2j8pB7+ �#       ��wC	?�y>|O�A�*

train_loss_263pB`�SM#       ��wC	��y>|O�A�*

train_loss_2.pBq��>#       ��wC	�y>|O�A�*

train_loss_2�(pB��'#       ��wC	+�y>|O�A�*

train_loss_2�#pB/��#       ��wC	�y>|O�A�*

train_loss_2ppB��i�#       ��wC	�y>|O�A�*

train_loss_2FpB-�f�#       ��wC	z>|O�A�*

train_loss_2pB�S_�#       ��wC	�z>|O�A�*

train_loss_2�pB3fq#       ��wC	y#z>|O�A�*

train_loss_2�	pB:��#       ��wC	Y3z>|O�A�*

train_loss_2�pBĨ#       ��wC	>>z>|O�A�*

train_loss_2��oB��EX#       ��wC	�Nz>|O�A�*

train_loss_2^�oBy�p�#       ��wC	Sxz>|O�A�*

train_loss_2>�oB\y>]#       ��wC	z�z>|O�A�*

train_loss_2�oBZD9#       ��wC	��z>|O�A�*

train_loss_2�oB��#       ��wC	�z>|O�A�*

train_loss_2��oBD:5#       ��wC	!�z>|O�A�*

train_loss_2��oBR~A�#       ��wC	��z>|O�A�*

train_loss_2��oB,}#       ��wC	q�z>|O�A�*

train_loss_2��oB6���#       ��wC	�z>|O�A�*

train_loss_2��oB��uG#       ��wC	��z>|O�A�*

train_loss_2z�oBsE�(#       ��wC	�{>|O�A�*

train_loss_2h�oB�LM�#       ��wC	c{>|O�A�*

train_loss_2Z�oB��S�#       ��wC	"{>|O�A�*

train_loss_2L�oB�>6u#       ��wC	�${>|O�A�*

train_loss_2@�oBԦr*#       ��wC	�,{>|O�A�*

train_loss_27�oB'˲?#       ��wC	5{>|O�A�*

train_loss_2/�oB�#��#       ��wC	�={>|O�A�*

train_loss_2'�oBf˓I#       ��wC	�F{>|O�A�*

train_loss_2$�oBw��#       ��wC	�N{>|O�A�*

train_loss_2�oB�B��#       ��wC	�Y{>|O�A�*

train_loss_2�oB}"#       ��wC	|b{>|O�A�*

train_loss_2�oB?�<�#       ��wC	jj{>|O�A�*

train_loss_2 �oBL�q�#       ��wC	�t{>|O�A�*

train_loss_2#�oB)�l#       ��wC	@�{>|O�A�*

train_loss_2(�oB���S#       ��wC	�{>|O�A�*

train_loss_23�oB���#       ��wC	��{>|O�A�*

train_loss_29|oBY8$�#       ��wC	�{>|O�A�*

train_loss_2BwoB����#       ��wC	��{>|O�A�*

train_loss_2OroBt��/#       ��wC	+�{>|O�A�*

train_loss_2[moB�<�%#       ��wC	��{>|O�A�*

train_loss_2ihoB�%#       ��wC	��{>|O�A�*

train_loss_2{coBFX�#       ��wC	s�{>|O�A�*

train_loss_2�^oBu�&�#       ��wC	Ѵ|>|O�A�*

train_loss_2�YoBH�4�#       ��wC	��|>|O�A�*

train_loss_2�ToB�D�#       ��wC	�|>|O�A�*

train_loss_2�OoBt��#       ��wC	h�|>|O�A�*

train_loss_2�JoBz+��#       ��wC	��|>|O�A�*

train_loss_2FoB��Ī#       ��wC	��|>|O�A�*

train_loss_2AoB�b�g#       ��wC	�|>|O�A�*

train_loss_2;<oB%lg#       ��wC	��|>|O�A�*

train_loss_2[7oB��pr#       ��wC	��|>|O�A�*

train_loss_2{2oBј#       ��wC	B�|>|O�A�*

train_loss_2�-oB@�?�#       ��wC	��|>|O�A�*

train_loss_2�(oB��#       ��wC	G�|>|O�A�*

train_loss_2�#oBw��#       ��wC	�}>|O�A�*

train_loss_2oBک�#       ��wC	�}>|O�A�*

train_loss_28oB��v�#       ��wC	�}>|O�A�*

train_loss_2boB��#       ��wC	`"}>|O�A�*

train_loss_2�oB�w��#       ��wC	8+}>|O�A�*

train_loss_2�oB%Zɮ#       ��wC	�6}>|O�A�*

train_loss_2�oBH��#       ��wC	h@}>|O�A�*

train_loss_2oB�4#       ��wC	�N}>|O�A�*

train_loss_2M�nB�?�r#       ��wC	O]}>|O�A�*

train_loss_2�nB�ja#       ��wC	�y}>|O�A�*

train_loss_2��nB^R��#       ��wC	�}>|O�A�*

train_loss_2��nB$��H#       ��wC	D�}>|O�A�*

train_loss_2#�nBTru�#       ��wC	;�}>|O�A�*

train_loss_2^�nB��JE#       ��wC	�	~>|O�A�*

train_loss_2��nB�LÕ#       ��wC	�~>|O�A�*

train_loss_2��nBAz~t#       ��wC	�~>|O�A�*

train_loss_2�nBcv0#       ��wC	� ~>|O�A�*

train_loss_2T�nB��3�#       ��wC	�(~>|O�A�*

train_loss_2��nB%ZO9#       ��wC	9/~>|O�A�*

train_loss_2��nBLN�#       ��wC	6~>|O�A�*

train_loss_2�nBZc��#       ��wC	�<~>|O�A�*

train_loss_2f�nBwX�#       ��wC	(C~>|O�A�*

train_loss_2��nB��#       ��wC	J~>|O�A�*

train_loss_2��nB�]�3#       ��wC	zQ~>|O�A�*

train_loss_2@�nB8&_?#       ��wC	�Z~>|O�A�*

train_loss_2��nBa^�l#       ��wC	�c~>|O�A�*

train_loss_2ڧnBd�ZM#       ��wC	�u~>|O�A�*

train_loss_2)�nBĊ��#       ��wC	,�~>|O�A�*

train_loss_2|�nB�3��#       ��wC	�~>|O�A�*

train_loss_2̙nB��#       ��wC	і~>|O�A�*

train_loss_2�nB@"��#       ��wC	�~>|O�A�*

train_loss_2t�nB�}�U#       ��wC	�~>|O�A�*

train_loss_2͋nB�R=�#       ��wC	ػ~>|O�A�*

train_loss_2$�nB�|T�#       ��wC	�~>|O�A�*

train_loss_2{�nBx��#       ��wC	�~>|O�A�*

train_loss_2�}nB���#       ��wC	T�~>|O�A�*

train_loss_26ynB��&#       ��wC	$�~>|O�A�*

train_loss_2�tnB]�k#       ��wC	��~>|O�A�*

train_loss_2�onB�l�#       ��wC	N
>|O�A�*

train_loss_2SknB�=�[#       ��wC	">|O�A�*

train_loss_2�fnB'^)�#       ��wC	J)>|O�A�*

train_loss_2bnB���#       ��wC	'5>|O�A�*

train_loss_2}]nB�H$0#       ��wC	�=>|O�A�*

train_loss_2�XnB}�ݱ#       ��wC	AG>|O�A�*

train_loss_2LTnB]e�#       ��wC	P>|O�A�*

train_loss_2�OnB^�j3#       ��wC	\X>|O�A�*

train_loss_2!KnB�q�#       ��wC	�_>|O�A�*

train_loss_2�FnBFh��#       ��wC	{i>|O�A�*

train_loss_2�AnBkl:�#       ��wC	�s>|O�A�*

train_loss_2l=nB�̔S#       ��wC	s~>|O�A�*

train_loss_2�8nB���#       ��wC	!�>|O�A�*

train_loss_2N4nBܼ�#       ��wC	��>|O�A�*

train_loss_2�/nB%!#       ��wC	�>|O�A�*

train_loss_26+nB(?��#       ��wC	
�>|O�A�*

train_loss_2�&nB�c#       ��wC	��>|O�A�*

train_loss_2#"nB̺ #       ��wC	x�>|O�A�*

train_loss_2�nB���-#       ��wC	��>|O�A�*

train_loss_2nB���#       ��wC	��>|O�A�*

train_loss_2�nB��#       ��wC	g�>|O�A�*

train_loss_2nBt��r#       ��wC	��>|O�A�*

train_loss_2�nB����#       ��wC	��>|O�A�*

train_loss_2nB|l#       ��wC	,�>|O�A�*

train_loss_2�nB�?_#       ��wC	oL�>|O�A�*

train_loss_2�mB��#       ��wC	�h�>|O�A�*

train_loss_2��mB�F^#       ��wC	g~�>|O�A�*

train_loss_2�mB#�8*#       ��wC	��>|O�A�*

train_loss_2��mB%ʊ#       ��wC	���>|O�A�*

train_loss_2.�mBW'Cf#       ��wC	wÀ>|O�A�*

train_loss_2��mBA:�#       ��wC	�Ѐ>|O�A�*

train_loss_2A�mBD���#       ��wC	�ހ>|O�A�*

train_loss_2��mB�#�#       ��wC	��>|O�A�*

train_loss_2[�mB�Cw#       ��wC	��>|O�A�*

train_loss_2��mB-�>�#       ��wC	��>|O�A�*

train_loss_2|�mBf{e#       ��wC	��>|O�A�*

train_loss_2�mB�Md�#       ��wC	S&�>|O�A�*

train_loss_2��mB�>��#       ��wC	�2�>|O�A�*

train_loss_25�mBT��-#       ��wC	lA�>|O�A�*

train_loss_2˿mB�׳�#       ��wC	�K�>|O�A�*

train_loss_2b�mBw�g�#       ��wC	CW�>|O�A�*

train_loss_2��mB��I�#       ��wC	9a�>|O�A�*

train_loss_2��mB��^#       ��wC	�l�>|O�A�*

train_loss_21�mB�
4#       ��wC	�v�>|O�A�*

train_loss_2̩mBZG�Q#       ��wC	���>|O�A�*

train_loss_2k�mB��E�#       ��wC	6��>|O�A�*

train_loss_2	�mB"�]�#       ��wC	���>|O�A�*

train_loss_2��mB1�	�#       ��wC	:��>|O�A�*

train_loss_2K�mBh{#       ��wC	༁>|O�A�*

train_loss_2�mB6�mP#       ��wC	!Ɂ>|O�A�*

train_loss_2��mB*"�#       ��wC	I�>|O�A�*

train_loss_2;�mB��#       ��wC	c$�>|O�A�*

train_loss_2��mBx���#       ��wC	�?�>|O�A�*

train_loss_2��mB�=�#       ��wC	�^�>|O�A�*

train_loss_23~mB3��8#       ��wC	�i�>|O�A�*

train_loss_2�ymB��	�#       ��wC	r�>|O�A�*

train_loss_2�umB0 '�#       ��wC	�|�>|O�A�*

train_loss_27qmB��#       ��wC	T��>|O�A�*

train_loss_2�lmB����#       ��wC	S��>|O�A�*

train_loss_2�hmB2��p#       ��wC	���>|O�A�*

train_loss_2GdmB���x#       ��wC	.��>|O�A�*

train_loss_2�_mB�Һ#       ��wC	���>|O�A�*

train_loss_2�[mB���a#       ��wC	Ӄ>|O�A�*

train_loss_2bWmB=�#       ��wC	#߃>|O�A�*

train_loss_2SmBr�z�#       ��wC	K�>|O�A�*

train_loss_2�NmB���#       ��wC	��>|O�A�*

train_loss_2�JmB�$�#       ��wC	���>|O�A�*

train_loss_2FFmBV�j#       ��wC		�>|O�A�*

train_loss_2BmB�L�>#       ��wC	��>|O�A�*

train_loss_2�=mBA��!#       ��wC	�"�>|O�A�*

train_loss_2z9mBc�C�#       ��wC	�0�>|O�A�*

train_loss_2:5mB����#       ��wC	�9�>|O�A�*

train_loss_2�0mB�@�#       ��wC	NE�>|O�A�*

train_loss_2�,mB��c,#       ��wC	iX�>|O�A�*

train_loss_2�(mB�
\m#       ��wC	4a�>|O�A�*

train_loss_2C$mB�?#       ��wC	�h�>|O�A�*

train_loss_2 mB���#       ��wC	�p�>|O�A�*

train_loss_2�mB��s�#       ��wC	�x�>|O�A�*

train_loss_2�mB�	;�#       ��wC	t��>|O�A�*

train_loss_2amB[SZC#       ��wC	��>|O�A�*

train_loss_2.mBO}$i#       ��wC	��>|O�A�*

train_loss_2�
mB��K#       ��wC	ș�>|O�A�*

train_loss_2�mB��$'#       ��wC	졄>|O�A�*

train_loss_2�mB��:a#       ��wC	2��>|O�A�*

train_loss_2b�lB�5%�#       ��wC	1��>|O�A�*

train_loss_23�lB��x�#       ��wC	o؄>|O�A�*

train_loss_2�lBmj |#       ��wC	T�>|O�A�*

train_loss_2��lB��#       ��wC	��>|O�A�*

train_loss_2��lB ��q#       ��wC	���>|O�A�*

train_loss_2�lB��7�#       ��wC	��>|O�A�*

train_loss_2U�lBb��#       ��wC	&�>|O�A�*

train_loss_20�lB1�L#       ��wC	k*�>|O�A�*

train_loss_2�lBMh[�#       ��wC	�5�>|O�A�*

train_loss_2��lBc��o#       ��wC	�D�>|O�A�*

train_loss_2��lB���#       ��wC	�Y�>|O�A�*

train_loss_2��lB�KYL#       ��wC	�}�>|O�A�*

train_loss_2v�lB(���#       ��wC	z��>|O�A�*

train_loss_2W�lBK2j�#       ��wC	���>|O�A�*

train_loss_25�lBb�z#       ��wC	f��>|O�A�*

train_loss_2�lB�9�#       ��wC	���>|O�A�*

train_loss_2��lBޕ�o#       ��wC	�>|O�A�*

train_loss_2ܷlB�d��#       ��wC	V��>|O�A�*

train_loss_2��lB�d]�#       ��wC	迅>|O�A�*

train_loss_2��lB�]�#       ��wC	:̅>|O�A�*

train_loss_2��lB���#       ��wC	��>|O�A�*

train_loss_2u�lBP�#       ��wC	��>|O�A�*

train_loss_2`�lBmJp#       ��wC	
�>|O�A�*

train_loss_2I�lBS;�#       ��wC	��>|O�A�*

train_loss_23�lB���#       ��wC	& �>|O�A�*

train_loss_2!�lBg���#       ��wC	��>|O�A�*

train_loss_2�lBg�#       ��wC	b�>|O�A�*

train_loss_2��lB{� #       ��wC	7�>|O�A�*

train_loss_2�lB�L��#       ��wC	�$�>|O�A�*

train_loss_2�lB1���#       ��wC	Z,�>|O�A�*

train_loss_2ӂlB:���#       ��wC	�4�>|O�A�*

train_loss_2�~lB�A��#       ��wC	�?�>|O�A�*

train_loss_2�zlB�eU##       ��wC	<J�>|O�A�*

train_loss_2�vlB�G�*#       ��wC	XY�>|O�A�*

train_loss_2�rlB[^1�#       ��wC	�h�>|O�A�*

train_loss_2�nlB�{IQ#       ��wC	�p�>|O�A�*

train_loss_2�jlB)f��#       ��wC	Jw�>|O�A�*

train_loss_2�flBUt�#       ��wC	[~�>|O�A�*

train_loss_2�blB�LF�#       ��wC	���>|O�A�*

train_loss_2�^lBf���#       ��wC	㊆>|O�A�*

train_loss_2�ZlB}6��#       ��wC	O��>|O�A�*

train_loss_2�VlB� ;�#       ��wC	5��>|O�A�*

train_loss_2�RlB��V{#       ��wC	���>|O�A�*

train_loss_2�NlB�3 �#       ��wC	հ�>|O�A�*

train_loss_2�JlBS! ?#       ��wC	���>|O�A�*

train_loss_2�FlB��#       ��wC	ņ>|O�A�*

train_loss_2�BlB���#       ��wC	�Ԇ>|O�A�*

train_loss_2�>lByJ��#       ��wC	��>|O�A�*

train_loss_2�:lBނ-#       ��wC	_�>|O�A�*

train_loss_2�6lB�Km�#       ��wC	��>|O�A�*

train_loss_2�2lBt��#       ��wC	C��>|O�A�*

train_loss_2�.lBh!n#       ��wC	��>|O�A�*

train_loss_2�*lB�=�#       ��wC	k�>|O�A�*

train_loss_2�&lB?�`$#       ��wC	��>|O�A�*

train_loss_2�"lB؁�O#       ��wC	~�>|O�A�*

train_loss_2�lBm���#       ��wC	�#�>|O�A�*

train_loss_2�lBG��E#       ��wC	�*�>|O�A�*

train_loss_2lB6o~a#       ��wC	�1�>|O�A�*

train_loss_2lB��\#       ��wC	�:�>|O�A�*

train_loss_20lB3�Z3#       ��wC	�D�>|O�A�*

train_loss_2ClB�}#       ��wC	�O�>|O�A�*

train_loss_2YlB��#       ��wC	b�>|O�A�*

train_loss_2llB�5#       ��wC	\t�>|O�A�*

train_loss_2��kB;d}�#       ��wC	܁�>|O�A�*

train_loss_2��kB�yo#       ��wC	��>|O�A�*

train_loss_2��kB [� #       ��wC	k��>|O�A�*

train_loss_2��kBp'I�#       ��wC	ƥ�>|O�A�*

train_loss_2��kBJH�R#       ��wC	S��>|O�A�*

train_loss_2�kB\JJ�#       ��wC	+��>|O�A�*

train_loss_2!�kB܊m�#       ��wC	 ň>|O�A�*

train_loss_2C�kB7��#       ��wC	�Έ>|O�A�*

train_loss_2_�kB2q��#       ��wC	Rو>|O�A�*

train_loss_2��kB�'�k#       ��wC	\�>|O�A�*

train_loss_2��kBG_s�#       ��wC	_�>|O�A�*

train_loss_2��kB��w�#       ��wC	"��>|O�A�*

train_loss_2��kB�v�#       ��wC	l�>|O�A�*

train_loss_2�kB$:�8#       ��wC	��>|O�A�*

train_loss_20�kB�f�#       ��wC	��>|O�A�*

train_loss_2W�kB��p�#       ��wC	��>|O�A�*

train_loss_2}�kB�9#       ��wC	�%�>|O�A�*

train_loss_2��kB"���#       ��wC	�,�>|O�A�*

train_loss_2йkB�''�#       ��wC	�2�>|O�A�*

train_loss_2��kBUi� #       ��wC	�8�>|O�A�*

train_loss_2&�kB��e�#       ��wC	�?�>|O�A�*

train_loss_2T�kB�7�#       ��wC	4G�>|O�A�*

train_loss_2��kB!�l #       ��wC	7O�>|O�A�*

train_loss_2��kB���#       ��wC	SX�>|O�A�*

train_loss_2ޢkB�;#       ��wC	�c�>|O�A�*

train_loss_2�kB��#       ��wC	(|�>|O�A�*

train_loss_2@�kB��O#       ��wC	���>|O�A�*

train_loss_2q�kB�V�=#       ��wC	��>|O�A�*

train_loss_2��kB���#       ��wC	à�>|O�A�*

train_loss_2ڏkB#K�^#       ��wC	e��>|O�A�*

train_loss_2�kB���#       ��wC	��>|O�A�*

train_loss_2H�kB�%�#       ��wC	���>|O�A�*

train_loss_2�kB�s�#       ��wC	3>|O�A�*

train_loss_2��kB㈽�#       ��wC	.ˉ>|O�A�*

train_loss_2�|kB�8z #       ��wC	5։>|O�A�*

train_loss_2*ykBd���#       ��wC	�߉>|O�A�*

train_loss_2eukB ���#       ��wC	��>|O�A�*

train_loss_2�qkB.�I#       ��wC	��>|O�A�*

train_loss_2�mkB[�<G#       ��wC	���>|O�A�*

train_loss_2jkBBu�#       ��wC	B�>|O�A�*

train_loss_2\fkB�a�#       ��wC	Z�>|O�A�*

train_loss_2�bkB�n��#       ��wC	��>|O�A�*

train_loss_2�^kB���s#       ��wC	6�>|O�A�*

train_loss_2"[kB���#       ��wC	_&�>|O�A�*

train_loss_2dWkB�f�#       ��wC	.�>|O�A�*

train_loss_2�SkB����#       ��wC	�7�>|O�A�*

train_loss_2�OkB䏍�#       ��wC	�@�>|O�A�*

train_loss_25LkBFR�6#       ��wC	xH�>|O�A�*

train_loss_2|HkB���#       ��wC	sN�>|O�A�*

train_loss_2�DkB��Ia#       ��wC	�T�>|O�A�*

train_loss_2AkB�	ޱ#       ��wC	�Z�>|O�A�*

train_loss_2X=kB+�#       ��wC	ga�>|O�A�*

train_loss_2�9kB|�9#       ��wC	�h�>|O�A�*

train_loss_2�5kB���#       ��wC	�t�>|O�A�*

train_loss_2;2kB8��#       ��wC	���>|O�A�*

train_loss_2�.kB��y#       ��wC	���>|O�A�*

train_loss_2�*kB��8#       ��wC	*��>|O�A�*

train_loss_2%'kB���#       ��wC	굊>|O�A�*

train_loss_2x#kB�z#       ��wC	#��>|O�A�*

train_loss_2�kBd��Z#       ��wC	�Ɗ>|O�A�*

train_loss_2kB5��L#       ��wC	�͊>|O�A�*

train_loss_2nkBúw@#       ��wC	�Ԋ>|O�A�*

train_loss_2�kBB�#       ��wC	�ۊ>|O�A�*

train_loss_2kBі��#       ��wC	L�>|O�A�*

train_loss_2lkB]�4�#       ��wC	��>|O�A�*

train_loss_2�	kBb��#       ��wC	��>|O�A�*

train_loss_2kB+_Gf#       ��wC	���>|O�A�*

train_loss_2tkB��Vx#       ��wC	J�>|O�A�*

train_loss_2��jBX'2�#       ��wC	��>|O�A�*

train_loss_2*�jB��#       ��wC	{�>|O�A�*

train_loss_2��jB���#       ��wC	��>|O�A�*

train_loss_2��jB>ol�#       ��wC	1+�>|O�A�*

train_loss_2@�jB��q�#       ��wC	r4�>|O�A�*

train_loss_2��jB�qYx#       ��wC	�<�>|O�A�*

train_loss_2��jBbG��#       ��wC	�C�>|O�A�*

train_loss_2]�jBn"O(#       ��wC	�M�>|O�A�*

train_loss_2��jB�h!#       ��wC	�W�>|O�A�*

train_loss_2 �jB����#       ��wC	�b�>|O�A�*

train_loss_2��jBF��#       ��wC	�p�>|O�A�*

train_loss_2��jB�q�h#       ��wC	���>|O�A�*

train_loss_2L�jB�©#       ��wC	�>|O�A�*

train_loss_2��jB�&�~#       ��wC	X��>|O�A�*

train_loss_2�jB�H�Q#       ��wC	b��>|O�A�*

train_loss_2��jB���#       ��wC	Xʋ>|O�A�*

train_loss_2��jBQhI#       ��wC	�܋>|O�A�*

train_loss_2Q�jB�`�#       ��wC	q�>|O�A�*

train_loss_2��jBK��#       ��wC	��>|O�A�*

train_loss_2&�jB�4^�#       ��wC	��>|O�A�*

train_loss_2��jB���#       ��wC	l�>|O�A�*

train_loss_2��jBc�`#       ��wC	��>|O�A�*

train_loss_2l�jB��+�#       ��wC	v�>|O�A�*

train_loss_2٫jB��S#       ��wC	>(�>|O�A�*

train_loss_2J�jBwr�q#       ��wC	�5�>|O�A�*

train_loss_2��jB���#       ��wC	�?�>|O�A�*

train_loss_2,�jB�{7#       ��wC	MI�>|O�A�*

train_loss_2��jBCRL#       ��wC	GS�>|O�A�*

train_loss_2�jBv��#       ��wC	�^�>|O�A�*

train_loss_2��jB���t#       ��wC	�g�>|O�A�*

train_loss_2��jB�o<#       ��wC	 t�>|O�A�*

train_loss_2l�jBx"Ы#       ��wC	ǁ�>|O�A�*

train_loss_2�jB�&�#       ��wC	��>|O�A�*

train_loss_2[�jBz��#       ��wC	��>|O�A�*

train_loss_2҄jB�M&�#       ��wC	̵�>|O�A�*

train_loss_2M�jBQY�r#       ��wC	2�>|O�A�*

train_loss_2�}jB!m��#       ��wC	��>|O�A�*

train_loss_2@zjB�R�#       ��wC	���>|O�A�*

train_loss_2�vjB=��#       ��wC	���>|O�A�*

train_loss_26sjB`�E�#       ��wC	��>|O�A�*

train_loss_2�ojB�c#       ��wC	��>|O�A�*

train_loss_22ljBG���#       ��wC	�!�>|O�A�*

train_loss_2�hjB�nb�#       ��wC	�.�>|O�A�*

train_loss_21ejB���!#       ��wC	q;�>|O�A�*

train_loss_2�ajB+�8=#       ��wC	�G�>|O�A�*

train_loss_21^jB��g#       ��wC	�Y�>|O�A�*

train_loss_2�ZjB�.x#       ��wC	jo�>|O�A�*

train_loss_26WjBZb��#       ��wC	{�>|O�A�*

train_loss_2�SjBĢ��#       ��wC	���>|O�A�*

train_loss_2>PjB7^XN#       ��wC	���>|O�A�*

train_loss_2�LjB*�yJ#       ��wC	̎>|O�A�*

train_loss_2JIjB?9=#       ��wC	
ێ>|O�A�*

train_loss_2�EjB1gK##       ��wC	���>|O�A�*

train_loss_2YBjB E��#       ��wC	�	�>|O�A�*

train_loss_2�>jB�]�d#       ��wC	8.�>|O�A�*

train_loss_2k;jB<�#       ��wC	!9�>|O�A�*

train_loss_2�7jB ��:#       ��wC	�R�>|O�A�*

train_loss_2�4jB�x2#       ��wC	b�>|O�A�*

train_loss_21jB��y�#       ��wC	~o�>|O�A�*

train_loss_2�-jB���#       ��wC	�}�>|O�A�*

train_loss_2&*jB�ɚ#       ��wC	"��>|O�A�*

train_loss_2�&jBM�A3#       ��wC	t��>|O�A�*

train_loss_2C#jB|D#       ��wC	���>|O�A�*

train_loss_2�jB.`i�#       ��wC	��>|O�A�*

train_loss_2djB�N��#       ��wC	0I�>|O�A�*

train_loss_2�jB�ۏ#       ��wC	�V�>|O�A�*

train_loss_2�jBr�͎#       ��wC	Vc�>|O�A�*

train_loss_2jB�pA#       ��wC	�o�>|O�A�*

train_loss_2�jB<6j�#       ��wC	J}�>|O�A�*

train_loss_2FjBa^e#       ��wC	���>|O�A�*

train_loss_2�jB��#       ��wC	W��>|O�A�*

train_loss_2pjB��D5#       ��wC	
��>|O�A�*

train_loss_2jB��#       ��wC	���>|O�A�*

train_loss_2��iB�H;%#       ��wC	���>|O�A�*

train_loss_2;�iBh$�#       ��wC	�Ð>|O�A�*

train_loss_2��iBV��#       ��wC	ѐ>|O�A�*

train_loss_2l�iB�"+�#       ��wC	�ܐ>|O�A�*

train_loss_2�iBfb 2#       ��wC	��>|O�A�*

train_loss_2��iB1�Z#       ��wC	��>|O�A�*

train_loss_2B�iB|U�#       ��wC	���>|O�A�*

train_loss_2��iB�r�/#       ��wC	6�>|O�A�*

train_loss_2{�iB���,#       ��wC	1�>|O�A�*

train_loss_2�iB�
��#       ��wC	
�>|O�A�*

train_loss_2��iB�)
#       ��wC	�&�>|O�A�*

train_loss_2\�iB�8sg#       ��wC	�1�>|O�A�*

train_loss_2��iB�#       ��wC	<�>|O�A�*

train_loss_2��iB��!#       ��wC	�F�>|O�A�*

train_loss_2B�iB�.�#       ��wC	�P�>|O�A�*

train_loss_2��iBv	p�#       ��wC	[�>|O�A�*

train_loss_2��iB�S(�#       ��wC	�f�>|O�A�*

train_loss_2.�iB}Lݪ#       ��wC	Uo�>|O�A�*

train_loss_2��iB�,�#       ��wC	�|�>|O�A�*

train_loss_2|�iB�X�=#       ��wC	<��>|O�A�*

train_loss_2"�iB%��#       ��wC	���>|O�A�*

train_loss_2ʶiB���#       ��wC	���>|O�A�*

train_loss_2r�iB�dW#       ��wC	R��>|O�A�*

train_loss_2�iB"yU�#       ��wC	���>|O�A�*

train_loss_2ǬiB$��#       ��wC	}��>|O�A�*

train_loss_2s�iBǵ}�#       ��wC	���>|O�A�*

train_loss_2�iB1��)#       ��wC	���>|O�A�*

train_loss_2ˢiBk6�#       ��wC	�Ǒ>|O�A�*

train_loss_2x�iB�i�#       ��wC	lБ>|O�A�*

train_loss_2'�iB.X_K#       ��wC	�ڑ>|O�A�*

train_loss_2ؘiB�E��#       ��wC	��>|O�A�*

train_loss_2��iB�a�A#       ��wC	��>|O�A�*

train_loss_27�iBy&�Q#       ��wC	���>|O�A�*

train_loss_2�iB�:<e#       ��wC	:�>|O�A�*

train_loss_2��iBbM�#       ��wC	��>|O�A�*

train_loss_2L�iBi��#       ��wC	��>|O�A�*

train_loss_2 �iB�3�#       ��wC	m�>|O�A�*

train_loss_2��iB�o#       ��wC	["�>|O�A�*

train_loss_2i~iB��1�#       ��wC	R*�>|O�A�*

train_loss_2{iB	�<:#       ��wC	{1�>|O�A�*

train_loss_2�wiBnQ�0#       ��wC	�9�>|O�A�*

train_loss_2�tiB�:�0#       ��wC	A�>|O�A�*

train_loss_2BqiB��:Y#       ��wC	�I�>|O�A�*

train_loss_2�miB��֮#       ��wC	�P�>|O�A�*

train_loss_2�jiB|d�~#       ��wC	W�>|O�A�*

train_loss_2ogiB[/�#       ��wC	W]�>|O�A�*

train_loss_2)diB����#       ��wC	�e�>|O�A�*

train_loss_2�`iBu��}#       ��wC	�m�>|O�A�*

train_loss_2�]iB�77#       ��wC	�u�>|O�A�*

train_loss_2^ZiB�s1#       ��wC	�}�>|O�A�*

train_loss_2WiB��#       ��wC	ׅ�>|O�A�*

train_loss_2�SiBt�R#       ��wC	猒>|O�A�*

train_loss_2�PiB�׭#       ��wC	���>|O�A�*

train_loss_2XMiB�b��#       ��wC	��>|O�A�*

train_loss_2JiB�c�"#       ��wC	��>|O�A�*

train_loss_2�FiB��D�#       ��wC	���>|O�A�*

train_loss_2�CiB��P #       ��wC	m��>|O�A�*

train_loss_2]@iB&�4�#       ��wC	���>|O�A�*

train_loss_2=iB<)#       ��wC	w��>|O�A�*

train_loss_2�9iBM_7#       ��wC	�Ȓ
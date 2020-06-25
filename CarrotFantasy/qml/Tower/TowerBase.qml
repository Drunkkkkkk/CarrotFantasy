import QtQuick 2.0
import Felgo 3.0


EntityBase{
    id: towerBase

    property QtObject targetEntity: null
    property real colliderRadius: 60
    property bool emitAimingAtTargetSignal: true

    //瞄准目标改变
    signal aimingAtTargetChanged(bool aimingAtTarget)
    signal targetRemoved();

    //当怪物死去的时候，清楚目标对象
    Connections {
        id: targetEntityConnection
        target: targetEntity
        //如果目标被破坏，请清除连接
        onEntityDestroyed:
            removeTarget();
    }

    //获取碰撞的实体
    CircleCollider{
        id: collider
        radius: colliderRadius

        x:-colliderRadius
        y:-colliderRadius

        categories: Box.Category2
        collidesWith: Box.Category1

        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            if(targetEntity)
                return;

            var fixture = other;
            var body = other.getBody()
            var entity = body.target;
            setTarget(entity);
        }

        fixture.onEndContact: {
            var entity = other.getBody().target;

            if(entity === targetEntity)
                removeTarget();
        }
    }
    // 为MovementAnimation或ColliderBase提供有关朝向目标移动时的方向和旋转的信息
    MoveToPointHelper {
        id: moveToPointHelper
        targetObject: targetEntity
        //设置此属性以允许当目标位于owningEntity前面时，outputYAxis属性变为1。
        //如果您不希望owningEntity向前移动，则可以将其设置为false，因此将输出属性限制为仅旋转。 默认值是true。
        allowSteerForward: false
        //allowSteerBackward
        property real aimingAngleThreshold: 10
        property bool aimingAtTarget: false

        onAimingAtTargetChanged: {
            if(emitAimingAtTargetSignal)
                towerBase.aimingAtTargetChanged(aimingAtTarget);
        }
        onTargetObjectChanged: {
            if(!targetObject)
                aimingAtTarget = false;
        }
        //设置瞄准，获取ab....
        onAbsoluteRotationDifferenceChanged: {
            //此属性保存owningEntity和目标之间的旋转差异的绝对值。 它总是大于或等于0且小于180.如果它大于90度，
            //则意味着目标处于不同的方向。 要确定目标是否在拥有实体所面向的当前方向的右侧（顺时针）或左侧（逆时针）侧
            //请检查outputXAx是正还是负。 如果是正数，则在右侧，否则在左侧。

            // 将aimingAtTarget设置为true，但只有在之前它没有瞄准时
            if(absoluteRotationDifference < aimingAngleThreshold && !aimingAtTarget)
                aimingAtTarget = true;
            // 将aimingAtTarget设置为false，但仅限于之前的瞄准
            else if(absoluteRotationDifference > aimingAngleThreshold && aimingAtTarget)
                aimingAtTarget = false;
        }
    }
    // 旋转角度和加速度
    MovementAnimation {
        target: towerBase
        property: "rotation"
        running: targetEntity ? true : false
        //加速度
        velocity: 300*moveToPointHelper.outputXAxis
        //这可以避免过度旋转，因此旋转得比允许的更远
        maxPropertyValueDifference: moveToPointHelper.absoluteRotationDifference
    }

    function removeTarget() {
        targetEntity = null;
        towerBase.targetRemoved();
    }

    function setTarget(target) {
        targetEntity = target;
    }

    function towerSelected(){
        //出现升级和出售的图标
    }
}

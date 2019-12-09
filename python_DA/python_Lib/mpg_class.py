
class Mpg:
    # class Variable

    
    # operator
    def __init__(self, manufacturer, model, displ, year, cyl, trans, drv, cty, hwy, fl, klass):
        self.mManufacturer = manufacturer
        self.mModel = model
        self.mDispl = round(float(displ), 1)
        self.mYear = int(year)
        self.mCyl = int(cyl)
        self.mTrans = trans
        self.mDrv = drv
        self.mCty = int(cty)
        self.mHwy = int(hwy)
        self.mFl = fl
        self.mKlass = klass
 
    # method
        
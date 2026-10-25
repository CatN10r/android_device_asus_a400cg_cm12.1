/*
 * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
 * Not a Contribution.
 *
 * Copyright (C) 2006 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.internal.telephony;

import static com.android.internal.telephony.RILConstants.*;

import android.content.Context;
import android.media.AudioManager;
import android.os.AsyncResult;
import android.os.Message;
import android.os.Parcel;
import android.telephony.PhoneNumberUtils;
import android.telephony.Rlog;
import android.telephony.SignalStrength;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import com.android.internal.telephony.uicc.IccCardApplicationStatus;
import com.android.internal.telephony.uicc.IccCardStatus;

/**
 * RIL customization for Asus_t00i devices
 *
 * {@hide}
 */
public class AsusRIL extends RIL {

    public AsusRIL(Context context, int NetworkType, int cdmaSubscription) {
        super(context, NetworkType, cdmaSubscription);
       mQANElements = 5;
    }

    public AsusRIL(Context context, int networkMode, int cdmaSubscription, Integer instanceId) {
        super(context, networkMode, cdmaSubscription, instanceId);
        mQANElements = 5;
    }


    @Override
    protected Object
    responseSignalStrength(Parcel p) {
        int numInts = 12;
        int response[];

        response = new int[numInts];
        for (int i = 0 ; i < numInts ; i++) {
            if (i > 6 && i < 12) {
        //We dont have LTE so mark these as INVALID
                response[i] = SignalStrength.INVALID;
            } else {
                response[i] = p.readInt();
            }
        }

        return new SignalStrength(response[0], response[1], response[2], response[3], response[4], response[5],
                response[6], response[7],response[8], response[9], response[10], response[11], true);
    }

}

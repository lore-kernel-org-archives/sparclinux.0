Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E91C61DA4
	for <sparclinux@archiver.kernel.org>; Wed, 15 Mar 2023 10:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCOKNG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjCOKMl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Mar 2023 06:12:41 -0400
Received: from 126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92B8A6286C
        for <sparclinux@vger.kernel.org>; Wed, 15 Mar 2023 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=i1mEHr7gUy5HbS6seVo2TktN4IwVeNpwIUic9vXFYYg=; b=f
        uW/+4T+iFwgvxv1cfi3m804zFig9ApFfqR14UQ45RQ1QthNucPmDrs5Hyniy9vnL
        QkyLD1b5zYj7Qd4HlFiyFFZX6P2cNmu5yYSLV9U5k6iXYTh5Jphu+wTgsaAfgw2I
        3K1Hpv77AcRQkl81Qy0uMvcti9waAN6xkY8wiYy6x4=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr1
 (Coremail) ; Wed, 15 Mar 2023 17:39:10 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 15 Mar 2023 17:39:10 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, jirislaby@kernel.org,
        sparclinux@vger.kernel.org
Subject: Re:Re: [PATCH] tty: vcc: add check for mdesc_grab()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <ZBFmlu/iKFPdUaPy@kroah.com>
References: <20230315061121.1741454-1-windhl@126.com>
 <ZBFmlu/iKFPdUaPy@kroah.com>
X-NTES-SC: AL_QuycCvScvEku5iiZYekXnkwQhu05Ucq4u/8l1YVVP5E0sinN6x8iQ0dTAEHp79iIOR+riCC+Xyhh7fZ8eahSY6CahST7qOjXJJ1ruCCRKoi/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <416fdd67.312b.186e4a34561.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wA3+J0_khFk2PcFAA--.18318W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiHgAzF2IxqIPIawACsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

CkF0IDIwMjMtMDMtMTUgMTQ6MzI6NTQsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMDI6MTE6MjFQTSArMDgwMCwg
TGlhbmcgSGUgd3JvdGU6Cj4+IEluIHZjY19wcm9iZSgpLCB3ZSBzaG91bGQgY2hlY2sgdGhlIHJl
dHVybiB2YWx1ZSBvZgo+PiBtZGVzY19ncmFiKCkgYXMgaXQgbWF5IHJldHVybiBOVUxMLiBXaGls
ZSB0aGUKPj4gdmlvX3ZkZXZfbm9kZSgpIGhhcyB0aGUgTlVMTC1jaGVjaywgYnV0IGlmIHRoZXJl
Cj4+IGlzIHN0aWxsIGEgY2FsbCB0byBtZGVzY19yZWxlYXNlKCkgd2hpY2ggbWF5IGNhdXNlCj4+
IGEgTlBEIGJ1Zy4KPgo+SGF2ZSB5b3UgYWN0dWFsbHkgdHJpZ2dlcmVkIHRoaXMgaXNzdWU/ICBJ
ZiBzbywgaG93Pwo+CgpIaSwgR3JlZywKVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciByZXBseS4K
CkluIGZhY3QsIEkgaGF2ZSBub3QgYWN0dWFsbHkgdHJpZ2dlcmVkIHRoaXMgaXNzdWUsIApidXQg
SSBpbmRlZWQgbWVldCBsb3RzIG9mIGNoZWNrcyBpbiBvdGhlciAqX2luaXQgZnVuY3Rpb25zLCBl
LmcuLCBtZGVzY19hZGlfaW5pdCgpL2xkY19pbml0KCkuCgpIb3dldmVyLCBpZiB3ZSBjYW4gbWFr
ZSBzdXJlIHRoZSByZXR1cm4gdmFsdWUgY2FuIG5ldmVyIGJlIE5VTEwgCndoZW4gb3VyIGtlcm5l
bCBleGVjdXRlIGludG8gdGhlc2UgKl9wcm9iZSBmdW5jdGlvbnMsIG15IHBhdGNocyBhcmUgaW5k
ZWVkIHVzZWxlc3MuCgpUaGFua3MgYW5kIHNvcnJ5IGZvciBhbnkgcG90ZW50aWFsIHRyb3VibGUu
CgpMaWFuZyAKCj4+IEZpeGVzOiA1ZDE3MTA1MGUyOGYgKCJzcGFyYzY0OiB2Y2M6IEVuYWJsZSBW
Q0MgcG9ydCBwcm9iZSBhbmQgcmVtb3ZhbCIpCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3
aW5kaGxAMTI2LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL3R0eS92Y2MuYyB8IDMgKysrCj4+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90dHkvdmNjLmMgYi9kcml2ZXJzL3R0eS92Y2MuYwo+PiBpbmRleCAzNGJhNmU1NDc4OWEuLmUz
YmE2M2QwYTkxZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy90dHkvdmNjLmMKPj4gKysrIGIvZHJp
dmVycy90dHkvdmNjLmMKPj4gQEAgLTYxMCw2ICs2MTAsOSBAQCBzdGF0aWMgaW50IHZjY19wcm9i
ZShzdHJ1Y3QgdmlvX2RldiAqdmRldiwgY29uc3Qgc3RydWN0IHZpb19kZXZpY2VfaWQgKmlkKQo+
PiAgCj4+ICAJaHAgPSBtZGVzY19ncmFiKCk7Cj4+ICAKPj4gKwlpZiAoIWhwKQo+PiArCQlyZXR1
cm4gLUVOT0RFVjsKPgo+VGhpcyBjaGFuZ2UgaXMgb2J2aW91c2x5IG5vdCBjb3JyZWN0IGFuZCBo
YXMgbm90IGJlZW4gdGVzdGVkLCBzb3JyeS4KPlBsZWFzZSBkbyBub3QgbWFrZSBjaGFuZ2VzIGxp
a2UgdGhpcyB3aXRob3V0IHByb3Blcmx5IHZhbGlkYXRpbmcgdGhlbS4KPgo+Z3JlZyBrLWgK

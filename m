Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530AAC433F5
	for <sparclinux@archiver.kernel.org>; Sun, 22 May 2022 09:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237889AbiEVJCr (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 22 May 2022 05:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbiEVJCq (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 22 May 2022 05:02:46 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 02:02:41 PDT
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D393517ABD
        for <sparclinux@vger.kernel.org>; Sun, 22 May 2022 02:02:41 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 22 May
 2022 16:51:50 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.156]
Date:   Sun, 22 May 2022 16:51:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5a2m5YW1?= <chenxuebing@jari.cn>
To:     davem@davemloft.net
Cc:     christophe.jaillet@wanadoo.fr, andreas@gaisler.com, arnd@arndb.de,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: sparc: Use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <d328f2.9e2.180eaf7308c.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAXIW+m+Yli0+w2AA--.611W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAOCmFEYxskqQAGsT
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguICBQcmVmZXJyZWQgaXMgc3Ryc2NweS4KClNpZ25lZC1vZmYtYnk6
IFh1ZUJpbmcgQ2hlbiA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBhcmNoL3NwYXJjL2tlcm5l
bC9pb3BvcnQuYyAgIHwgMiArLQogYXJjaC9zcGFyYy9rZXJuZWwvc2V0dXBfMzIuYyB8IDIgKy0K
IGFyY2gvc3BhcmMva2VybmVsL3NldHVwXzY0LmMgfCAyICstCiBhcmNoL3NwYXJjL3Byb20vYm9v
dHN0cl8zMi5jIHwgMiArLQogNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9rZXJuZWwvaW9wb3J0LmMgYi9hcmNo
L3NwYXJjL2tlcm5lbC9pb3BvcnQuYwppbmRleCA0ZTRmM2QzMjYzZTQuLmE4Y2JlNDAzMzAxZiAx
MDA2NDQKLS0tIGEvYXJjaC9zcGFyYy9rZXJuZWwvaW9wb3J0LmMKKysrIGIvYXJjaC9zcGFyYy9r
ZXJuZWwvaW9wb3J0LmMKQEAgLTE5MSw3ICsxOTEsNyBAQCBzdGF0aWMgdm9pZCBfX2lvbWVtICpf
c3BhcmNfYWxsb2NfaW8odW5zaWduZWQgaW50IGJ1c25vLCB1bnNpZ25lZCBsb25nIHBoeXMsCiAJ
CXRhY2sgKz0gc2l6ZW9mIChzdHJ1Y3QgcmVzb3VyY2UpOwogCX0KIAotCXN0cmxjcHkodGFjaywg
bmFtZSwgWE5NTE4rMSk7CisJc3Ryc2NweSh0YWNrLCBuYW1lLCBYTk1MTisxKTsKIAlyZXMtPm5h
bWUgPSB0YWNrOwogCiAJdmEgPSBfc3BhcmNfaW9yZW1hcChyZXMsIGJ1c25vLCBwaHlzLCBzaXpl
KTsKZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMva2VybmVsL3NldHVwXzMyLmMgYi9hcmNoL3NwYXJj
L2tlcm5lbC9zZXR1cF8zMi5jCmluZGV4IGM4ZTBkZDk5ZjM3MC4uYWNlMGU5YWRmZDc3IDEwMDY0
NAotLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9zZXR1cF8zMi5jCisrKyBiL2FyY2gvc3BhcmMva2Vy
bmVsL3NldHVwXzMyLmMKQEAgLTMwMiw3ICszMDIsNyBAQCB2b2lkIF9faW5pdCBzZXR1cF9hcmNo
KGNoYXIgKipjbWRsaW5lX3ApCiAKIAkvKiBJbml0aWFsaXplIFBST00gY29uc29sZSBhbmQgY29t
bWFuZCBsaW5lLiAqLwogCSpjbWRsaW5lX3AgPSBwcm9tX2dldGJvb3RhcmdzKCk7Ci0Jc3RybGNw
eShib290X2NvbW1hbmRfbGluZSwgKmNtZGxpbmVfcCwgQ09NTUFORF9MSU5FX1NJWkUpOworCXN0
cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsICpjbWRsaW5lX3AsIENPTU1BTkRfTElORV9TSVpFKTsK
IAlwYXJzZV9lYXJseV9wYXJhbSgpOwogCiAJYm9vdF9mbGFnc19pbml0KCpjbWRsaW5lX3ApOwpk
aWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9rZXJuZWwvc2V0dXBfNjQuYyBiL2FyY2gvc3BhcmMva2Vy
bmVsL3NldHVwXzY0LmMKaW5kZXggNDhhYmVlNGVlZTI5Li42NTQ2Y2E5ZDRkM2YgMTAwNjQ0Ci0t
LSBhL2FyY2gvc3BhcmMva2VybmVsL3NldHVwXzY0LmMKKysrIGIvYXJjaC9zcGFyYy9rZXJuZWwv
c2V0dXBfNjQuYwpAQCAtNjM2LDcgKzYzNiw3IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hh
ciAqKmNtZGxpbmVfcCkKIHsKIAkvKiBJbml0aWFsaXplIFBST00gY29uc29sZSBhbmQgY29tbWFu
ZCBsaW5lLiAqLwogCSpjbWRsaW5lX3AgPSBwcm9tX2dldGJvb3RhcmdzKCk7Ci0Jc3RybGNweShi
b290X2NvbW1hbmRfbGluZSwgKmNtZGxpbmVfcCwgQ09NTUFORF9MSU5FX1NJWkUpOworCXN0cnNj
cHkoYm9vdF9jb21tYW5kX2xpbmUsICpjbWRsaW5lX3AsIENPTU1BTkRfTElORV9TSVpFKTsKIAlw
YXJzZV9lYXJseV9wYXJhbSgpOwogCiAJYm9vdF9mbGFnc19pbml0KCpjbWRsaW5lX3ApOwpkaWZm
IC0tZ2l0IGEvYXJjaC9zcGFyYy9wcm9tL2Jvb3RzdHJfMzIuYyBiL2FyY2gvc3BhcmMvcHJvbS9i
b290c3RyXzMyLmMKaW5kZXggZTNiNzMxZmYwMGYwLi4xYzdjZDI1OGIwZGMgMTAwNjQ0Ci0tLSBh
L2FyY2gvc3BhcmMvcHJvbS9ib290c3RyXzMyLmMKKysrIGIvYXJjaC9zcGFyYy9wcm9tL2Jvb3Rz
dHJfMzIuYwpAQCAtNTIsNyArNTIsNyBAQCBwcm9tX2dldGJvb3RhcmdzKHZvaWQpCiAJCSAqIFYz
IFBST00gY2Fubm90IHN1cHBseSBhcyB3aXRoIG1vcmUgdGhhbiAxMjggYnl0ZXMKIAkJICogb2Yg
YW4gYXJndW1lbnQuIEJ1dCBhIHNtYXJ0IGJvb3RzdHJhcCBsb2FkZXIgY2FuLgogCQkgKi8KLQkJ
c3RybGNweShiYXJnX2J1ZiwgKnJvbXZlYy0+cHZfdjJib290YXJncy5ib290YXJncywgc2l6ZW9m
KGJhcmdfYnVmKSk7CisJCXN0cnNjcHkoYmFyZ19idWYsICpyb212ZWMtPnB2X3YyYm9vdGFyZ3Mu
Ym9vdGFyZ3MsIHNpemVvZihiYXJnX2J1ZikpOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlicmVh
azsKLS0gCjIuMzYuMQoKCg==

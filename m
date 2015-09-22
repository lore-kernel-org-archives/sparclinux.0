From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 22 Sep 2015 03:35:50 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <CACVXFVO4cp7W7K=rkrD3j+EWzmJu1zbwmi1myTEA24bovdi9MQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001a11402802cbfb8805204db149"
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee>
	<CACVXFVN2fgG_rLTMby=bY+1sWzoGryKq_aCU2S0=chAX9MUvog@mail.gmail.com>
	<alpine.LRH.2.20.1509211024110.530@math.ut.ee>
	<CACVXFVNe5TrYr9gPrR4ggtg1cSbCcNt4_=vkBsGOv3fKocCzPg@mail.gmail.com>
	<alpine.LRH.2.20.1509211338410.530@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1509211338410.530@math.ut.ee>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>

--001a11402802cbfb8805204db149
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 21, 2015 at 7:43 PM, Meelis Roos <mroos@linux.ee> wrote:
>
>
> Yes, sorry - I applied the last chunk by hand because it was mangled by
> the web UI, and added ti to a wrong struct.
>
> Now I tested it on top of 4.3.0-rc1. COmpiles, rebooted fine 6 times,
> but now it hangs again, seems to be the same message:
>
> [  107.143910] kobject (00000000009f2dd8): tried to init an initialized object, something is seriously wrong.

Looks a bit odd since blk_mq_register_disk is run only once per device,
could you apply the attached debug patch and post the boot log when the
warning is triggered?

Thanks,

--001a11402802cbfb8805204db149
Content-Type: text/x-patch; charset=US-ASCII; name="blk-mq-kobj-init.patch"
Content-Disposition: attachment; filename="blk-mq-kobj-init.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ieut2yjc0

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS1zeXNmcy5jIGIvYmxvY2svYmxrLW1xLXN5c2ZzLmMK
aW5kZXggMjc5YzVkNi4uZDA5YzUxMSAxMDA2NDQKLS0tIGEvYmxvY2svYmxrLW1xLXN5c2ZzLmMK
KysrIGIvYmxvY2svYmxrLW1xLXN5c2ZzLmMKQEAgLTQwMywxMyArNDAzLDIwIEBAIHN0YXRpYyB2
b2lkIGJsa19tcV9zeXNmc19pbml0KHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQogCXN0cnVjdCBi
bGtfbXFfY3R4ICpjdHg7CiAJaW50IGk7CiAKKwlwcmludGsoIiVzOiBpbml0IG1xX2tvYmogJXBc
biIsIF9fZnVuY19fLCAmcS0+bXFfa29iaik7CiAJa29iamVjdF9pbml0KCZxLT5tcV9rb2JqLCAm
YmxrX21xX2t0eXBlKTsKIAotCXF1ZXVlX2Zvcl9lYWNoX2h3X2N0eChxLCBoY3R4LCBpKQorCXF1
ZXVlX2Zvcl9lYWNoX2h3X2N0eChxLCBoY3R4LCBpKSB7CisJCXByaW50aygiJXM6IGluaXQgaGN0
eF9rb2JqICVwICVkXG4iLCBfX2Z1bmNfXywKKwkJCQkmaGN0eC0+a29iaiwgaSk7CiAJCWtvYmpl
Y3RfaW5pdCgmaGN0eC0+a29iaiwgJmJsa19tcV9od19rdHlwZSk7CisJfQogCi0JcXVldWVfZm9y
X2VhY2hfY3R4KHEsIGN0eCwgaSkKKwlxdWV1ZV9mb3JfZWFjaF9jdHgocSwgY3R4LCBpKSB7CisJ
CXByaW50aygiJXM6IGluaXQgY3R4X2tvYmogJXAgJWRcbiIsIF9fZnVuY19fLAorCQkJCSZjdHgt
PmtvYmosIGkpOwogCQlrb2JqZWN0X2luaXQoJmN0eC0+a29iaiwgJmJsa19tcV9jdHhfa3R5cGUp
OworCX0KIH0KIAogLyogc2VlIGJsa19yZWdpc3Rlcl9xdWV1ZSgpICovCg==
--001a11402802cbfb8805204db149--

Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D9C54EAA
	for <sparclinux@archiver.kernel.org>; Mon, 30 Jan 2023 09:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjA3JtM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 04:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjA3JtL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 30 Jan 2023 04:49:11 -0500
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 01:49:07 PST
Received: from mail.gluegivebiz.com (mail.gluegivebiz.com [94.177.230.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEA1A487
        for <sparclinux@vger.kernel.org>; Mon, 30 Jan 2023 01:49:07 -0800 (PST)
Received: by mail.gluegivebiz.com (Postfix, from userid 1001)
        id 539758276D; Mon, 30 Jan 2023 09:30:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gluegivebiz.com;
        s=mail; t=1675071077;
        bh=5n0LayKpRHsZMclE7BidCW6LDGRdzRVHcrHQCq8kNN4=;
        h=Date:From:To:Subject:From;
        b=oqHiwlfgeBroSLZgsxiTvjiEvFnfjxG0Dz8LtYlYF2DCqJbHi9Bi0at7+222wcJU4
         /2LjqGzvkApd87DjZs0hQGX3zKTDn7IT4HWiDe8agRKF9CrkyASgg/7kGPrJ40/MOD
         Pdfv3JzpQ2psweqqIMAr1O64yknuk1XKMu+P8q8Z0y6vSPsIa7vSWOmlHBfW5p5dK5
         l4lHTqAhiM4CIor+fJSWaM1w4zzfOgCDdd/1EqGf5MCdg9mHGlAcEZ23lZ+2kLmOmy
         k1DZdxtuuUJaCt+swKndZbgfkfFDFWImv0Tk9N6zv65hSofNUKCziLkHBqq67m5pzG
         eTVTH925tWtHA==
Received: by mail.gluegivebiz.com for <sparclinux@vger.kernel.org>; Mon, 30 Jan 2023 09:30:36 GMT
Message-ID: <20230130084706-0.1.11.2p8y.0.sc6phliadn@gluegivebiz.com>
Date:   Mon, 30 Jan 2023 09:30:36 GMT
From:   =?UTF-8?Q? "Vil=C3=A9m_Du=C5=A1ek" ?= 
        <vilem.dusek@gluegivebiz.com>
To:     <sparclinux@vger.kernel.org>
Subject: =?UTF-8?Q?Tepeln=C3=A9_obr=C3=A1b=C4=9Bn=C3=AD_=E2=80=93_objedn=C3=A1vka?=
X-Mailer: mail.gluegivebiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Dobr=C3=BD den,

m=C3=A1te z=C3=A1jem o vyu=C5=BEit=C3=AD velmi kvalitn=C3=AD slu=C5=BEby =
tepeln=C3=A9ho obr=C3=A1b=C4=9Bn=C3=AD kov=C5=AF?

M=C5=AF=C5=BEeme v=C3=A1m nab=C3=ADdnout velmi v=C3=BDhodn=C3=A9 podm=C3=AD=
nky spolupr=C3=A1ce, technick=C3=A9 poradenstv=C3=AD, s=C3=A9riovou v=C3=BD=
robu a testov=C3=A1n=C3=AD prototyp=C5=AF.

Specializujeme se na tradi=C4=8Dn=C3=AD a vakuov=C3=A9 technologie: cemen=
tov=C3=A1n=C3=AD, nitrocementov=C3=A1n=C3=AD, kalen=C3=AD v plynu, zu=C5=A1=
lecht=C4=9Bn=C3=AD, =C5=BE=C3=ADh=C3=A1n=C3=AD, p=C3=A1jen=C3=AD, normali=
za=C4=8Dn=C3=AD =C5=BE=C3=ADh=C3=A1n=C3=AD (s p=C5=99ekrystalizac=C3=AD).

M=C3=A1me k dispozici rozs=C3=A1hl=C3=A9 strojn=C3=AD vybaven=C3=AD, velk=
=C3=BD t=C3=BDm odborn=C3=ADk=C5=AF, a proto jsme schopni se p=C5=99izp=C5=
=AFsobit va=C5=A1im po=C5=BEadavk=C5=AFm.

Pracujeme v souladu s na=C5=A1imi certifik=C3=A1ty v rozsahu norem platn=C3=
=BDch v oblasti automobilov=C3=A9ho pr=C5=AFmyslu (IATF 16949; CQI 9) a t=
ak=C3=A9 letectv=C3=AD (akreditace NADCAP).

Pokud m=C3=A1te po=C5=BEadavky v t=C3=A9to oblasti, r=C3=A1d v=C3=A1m p=C5=
=99edstav=C3=ADm na=C5=A1e mo=C5=BEnosti.

Mohl bych v=C3=A1m zatelefonovat?


Vil=C3=A9m Du=C5=A1ek

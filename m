Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FCC7EE23
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 03:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEEDHB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 23:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEEDHA (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 23:07:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101A11603;
        Thu,  4 May 2023 20:06:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1042920b3a.1;
        Thu, 04 May 2023 20:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683256016; x=1685848016;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clDf0mag7jSJOcBrV8uy3dVBVfVUaL1M4k8bgRC2I4s=;
        b=ZgbOpyAhMkj8DW2/1MjEkpRHTBanrpSvOIXdvw2BbjHVmZ3yQvz/iIqqqBoF62VREp
         0KPDwGbr8UkfcN/CdmloQHP/wMuOlu8WKNZwWqeLgpyxaqRlsAs8yJS74nIG9A+MoQgW
         GiM4xHJ4mGmhdHZC/EMJNHdHGTLyv2rN2XTODv2WApYaZiJoFXZ/07rkA/ewdFm9ZXrK
         iqBaFLdxuZpZeOKyIY3Iv1JZRUDo6TdPC/mDg2HHKld1Jiyoa9GXwVjzVX2qUXZO2bkw
         N4dzuSlzQMFUVCknsGFbdRBLFBpdBeX3NTx4XpMRWbR7QEUT8nPGpfd5Ln1naff9xKgb
         Pa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256016; x=1685848016;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=clDf0mag7jSJOcBrV8uy3dVBVfVUaL1M4k8bgRC2I4s=;
        b=fEt3yFMfTA6sYQmS6AQi22JpaHGBR8fzqN32uA5WPKdNXSVe06w1quZdHgLWjZsaVI
         +d/zR8fiM40CJtlNm2d2nHX9OffZ+k/citUyogUS0jZQXAQ/ear5DUdhkbQMcFJ6Nh7p
         sDzev+wUHa2BVPl3kIKlGR1eiK5hKFQ8ZocOU1qaDlFo69478Znn8otsglluyqTnoBbi
         JBKc3JZWAR7fII+fCF+0CXLO+9X7wxmQTJMnEnOToYWQwH2WQSmsDTIyeQ2VsVLbM0uF
         8U1Ejzw+o7QbEAxMcnMwfGo4zFTeYLxH7erMx2kMgmHhlGNbxeruZX2Pz6KM9b0/jiAu
         QvdQ==
X-Gm-Message-State: AC+VfDwAy5M80JJLU3WLeq5b6CznCdzUbge86O48U8fqjdEHhT6KUOVX
        9rXjDpJ/Av/EhPN3Rzo4Tto=
X-Google-Smtp-Source: ACHHUZ46P1P4WoTqpa9RKU3PzJiT096JVizromiqphOqiUBMf2I/jgGp4hWYnFU/0f2fFZ7lH7p5+A==
X-Received: by 2002:a05:6a20:9d8e:b0:ef:bd:38 with SMTP id mu14-20020a056a209d8e00b000ef00bd0038mr4174463pzb.55.1683256016392;
        Thu, 04 May 2023 20:06:56 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001aafa2e4716sm356432plh.264.2023.05.04.20.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:06:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 13:06:41 +1000
Message-Id: <CSE0GBQQDUAY.1QAJIC3D3OBVU@wheely>
Cc:     "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 11/17] watchdog/hardlockup: Rename some "NMI
 watchdog" constants/function
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
In-Reply-To: <20230504151100.v4.11.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> Do a search and replace of:
> - NMI_WATCHDOG_ENABLED =3D> HARD_WATCHDOG_ENABLED
> - watchdog_nmi_ =3D> watchdog_hardlockup_

These are just making prefixes inconsistent again.

If you really want to do a prefix, I would call it hardlockup which
probably best matches existing code and sysctl / boot stuff, and
concentrate on non-static symbols.

No problem with minor things like this that touch arch/powerpc
going through Andrew's tree though. I'm sure sparc maintainers
wouldn't mind either.

Thanks,
Nick

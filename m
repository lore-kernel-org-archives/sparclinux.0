Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49183C43460
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B3C61460
	for <sparclinux@archiver.kernel.org>; Fri, 23 Apr 2021 10:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhDWLA0 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhDWLAZ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 23 Apr 2021 07:00:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D4C06138C
        for <sparclinux@vger.kernel.org>; Fri, 23 Apr 2021 03:59:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y204so24363792wmg.2
        for <sparclinux@vger.kernel.org>; Fri, 23 Apr 2021 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=POTZ/1KbTme2ehdkYN4t8NUzorpYmuLDB40ValCRCzY=;
        b=GQ9SWSJA7G7fyBqL5po7yWgTUyHybJVBlTbgimQMgeLWnHWPXCKisioR3lZg+tWt9h
         z7HehOh3qZDxqUF30ai6ZxU2U1Ow8Hgk0PqsAAC8Krl1BFBv1LZT6QdVT/JFwyXax67L
         yuhPNrcw/yNhw/HJ/+mBzX14R/l6x0ltK3lCOOHEpIJIqdhDC2YNufJNDNzcMBJzYj7J
         qXutqCgEPewjWKcMIBsTzFe/Bmpc7u7/mRj+o83NFL3pJXd98Xo9so+tu+SwhEVXrFw7
         JXcq+GREZl6F3rYzfj9RA96tSdlkEWNtZt6P/WPXfX78yWs83/u4GkJ5e7gZ4nQ0GGXG
         J7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POTZ/1KbTme2ehdkYN4t8NUzorpYmuLDB40ValCRCzY=;
        b=WzaweqsPNQEGo1iSQlmLuAkcgJEhmUqLf2Vuy5SzVspWzJ508WfSaJRRHlu4rhQk1V
         MKZvNBzNTLna5M6+BhkFt8eB3uOPESq+yOkUtcJQxw1XayegqYU8qGx6xaor0PybkHQf
         O5m7m+F0O8XkhWfPD2XI36SxvO0XXKyP7mKCbMXBK+jeVnbRTCddPL5FrFpneu6AYm31
         2TA2/DD5QBvWqo73KAB3UMr/x9KlGX7+vnAJDO0J6sRUf+fnrY2MNGs05vWl1oZPvI7m
         rr4WKD09anKlTIvrlMYdjjCcIb3f8zXhHZSLx3LhOaff4b5pbJE2RWBIiWI1TqCMorwJ
         ieWw==
X-Gm-Message-State: AOAM532h9FJyemwWKbkkROcDZhH9DmzRlW8Bnh7VwjuX555hNesfAa52
        3emmP8X87aOaul3bVX6jA7f8aw==
X-Google-Smtp-Source: ABdhPJzObvm9TMswQFwB877SBftpV3WuHpQFVBzCA+XkW+5tO9tLL2qswInPQ8jeRFQ5yWhqFZ0H4A==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr3570424wmf.104.1619175586997;
        Fri, 23 Apr 2021 03:59:46 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.88.56])
        by smtp.gmail.com with ESMTPSA id e18sm9152733wrc.85.2021.04.23.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 03:59:46 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] bpf: Remove bpf_jit_enable=2 debugging mode
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Will Deacon <will@kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, paulburton@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-mips@vger.kernel.org, grantseltzer@gmail.com,
        Xi Wang <xi.wang@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        KP Singh <kpsingh@kernel.org>, iecedge@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Yonghong Song <yhs@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>, tsbogend@alpha.franken.de,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Wang YanQing <udknight@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, bpf <bpf@vger.kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20210415093250.3391257-1-Jianlin.Lv@arm.com>
 <9c4a78d2-f73c-832a-e6e2-4b4daa729e07@iogearbox.net>
 <d3949501-8f7d-57c4-b3fe-bcc3b24c09d8@isovalent.com>
 <CAADnVQJ2oHbYfgY9jqM_JMxUsoZxaNrxKSVFYfgCXuHVpDehpQ@mail.gmail.com>
 <0dea05ba-9467-0d84-4515-b8766f60318e@csgroup.eu>
 <CAADnVQ+oQT6C7Qv7P5TV-x7im54omKoCYYKtYhcnhb1Uv3LPMQ@mail.gmail.com>
 <be132117-f267-5817-136d-e1aeb8409c2a@csgroup.eu>
 <58296f87-ad00-a0f5-954b-2150aa84efc4@isovalent.com>
 <6a809d3f-c9e3-0eb7-9c1d-a202ad848424@csgroup.eu>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <ab1c3803-179c-7882-2bba-9eeda5211ad1@isovalent.com>
Date:   Fri, 23 Apr 2021 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6a809d3f-c9e3-0eb7-9c1d-a202ad848424@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

2021-04-23 12:46 UTC+0200 ~ Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> 
> Le 23/04/2021 à 12:26, Quentin Monnet a écrit :
>> 2021-04-23 09:19 UTC+0200 ~ Christophe Leroy
>> <christophe.leroy@csgroup.eu>
>>
>> [...]
>>
>>> I finally managed to cross compile bpftool with libbpf, libopcodes,
>>> readline, ncurses, libcap, libz and all needed stuff. Was not easy but I
>>> made it.
>>
>> Libcap is optional and bpftool does not use readline or ncurses. May I
>> ask how you tried to build it?
> 
> cd tools/bpf/
> 
> make ARCH=powerpc CROSS_COMPILE=ppc-linux-

Ok, you could try running directly from tools/bpf/bpftool/ next time
instead.

Readline at least is for a different tool under tools/bpf/, bpf_dbg (But
I'm still not sure where that ncurses requirement was pulled from). The
requirements for specific kernel options probably came from yet another
tool (runqslower, I think).

Quentin

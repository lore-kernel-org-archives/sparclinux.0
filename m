Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E51CCA47B
	for <sparclinux@archiver.kernel.org>; Sat, 11 Jun 2022 02:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiFKCX1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiFKCXT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 10 Jun 2022 22:23:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647C3F4A07
        for <sparclinux@vger.kernel.org>; Fri, 10 Jun 2022 19:23:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o10so1030498edi.1
        for <sparclinux@vger.kernel.org>; Fri, 10 Jun 2022 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvaEucNyttJ72r4dgkt1sbWCJsvBPyIh5zMt0LNXalY=;
        b=D62jI1p8sOcmW+dGG367yCKI6736qfwlRYdRbtg+pQI3VQ/mZvhMkSh4muEy4yFzXi
         1pifN6keFBPADAFAutLs2f+vKDRy3jOy1SmannYfmHY7tjbpoLbP8600CMqIboz22zit
         FmdCeKC+IDyY3i3YwKCGDz5In1oYgHbIW3q58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvaEucNyttJ72r4dgkt1sbWCJsvBPyIh5zMt0LNXalY=;
        b=UydVUSS3XtbZZxncQ4PRfpck42sXaBPygAgaFXsJnyaMaA8flABrZxkHWgQnl0d3cv
         q0S9skGo6iP+VrpvLV60CIVV7RUYjv9/uT4/NjwTLRQqIpMXdEyyHo9SUthf1ayWheLu
         c+GOEuRpgoHOmqZ3AgD2/J+esVG6UCJDm+qlDTSSaPZO/FNsKA0NEQwl2AqHv8GUyuRA
         0Ykd820QorL/cRUBS/4OrIw/PZi0O8C7CA6zMVy6Jg8nZAwHfQ2bW41580Mj3UMx5Q3y
         UdBqXqCeifNxaAmKKDBccRjplRRjCTLflYtic6hK7xS/C4DfPg81+9CyarmdK8fptqat
         lAew==
X-Gm-Message-State: AOAM533hRI6TfCn3hCRkGMV2c0yPRKL2N8SZWqSAqdenAliUfrq1j+bP
        v2OKQ0voPpNCvj/LE5z7WbgpfFizBKX9MDAYbyD5iA==
X-Google-Smtp-Source: ABdhPJz16+9kQdS9QDTB0tjL4FsLbUEsFaIS0ykQfnx5qpyFYyBQCn1i8W4mcCkA/y3viUzYkXAgYYv9JpSOTwgMdpQ=
X-Received: by 2002:a50:eb91:0:b0:42d:c1d8:616a with SMTP id
 y17-20020a50eb91000000b0042dc1d8616amr54940771edr.219.1654914192936; Fri, 10
 Jun 2022 19:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley> <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net> <YqHwOFg/WlMqe8/Z@alley>
In-Reply-To: <YqHwOFg/WlMqe8/Z@alley>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Sat, 11 Jun 2022 11:23:02 +0900
Message-ID: <CA+_sPaq_47C2PWnGU7WfGXMc03E1Nz+1=F-wZe0B2+ymqdm3Fg@mail.gmail.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        john.ogness@linutronix.de, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jun 9, 2022 at 10:06 PM Petr Mladek <pmladek@suse.com> wrote:
>
> Makes sense. Feel free to use for this patch:
>
> Acked-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

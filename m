Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBA8C4167D
	for <sparclinux@archiver.kernel.org>; Thu, 17 Nov 2022 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiKQW60 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiKQW6Y (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 17 Nov 2022 17:58:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876220983
        for <sparclinux@vger.kernel.org>; Thu, 17 Nov 2022 14:58:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3395402pjl.3
        for <sparclinux@vger.kernel.org>; Thu, 17 Nov 2022 14:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gB4fu8WxG++brcac1xEx09Jo8IsSv6jaRuNq5hahL+I=;
        b=Fy4BdUGW9a1WNEtqYFLG188KBaVxCW7dlYHJCJYByhqbYzWtrREex26XefPtc0cld6
         YCRtECSkUML5k6sMmax4MrQy/8YHDQGVY6nBvl6IgyA0kq1FCwf8z9yqhcxsos46Zhwv
         H1rDgpoCNHoreRPMRNhXYMHZ9u7/T1h/SC+nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB4fu8WxG++brcac1xEx09Jo8IsSv6jaRuNq5hahL+I=;
        b=RtDwlBwYlXZ2sLK71gPSwiRyPKjxarXxBuertIV9tLaJPjncsxTUcqzGbY/y9lJpFn
         QZxjPrzPpECcWB1AbIIUU3xQ9dYBftZcQvcysl30/52AFMq/L6Emnv2Uk5YqAjgP8PUN
         WerT079s/2sVEG0CpakdDkrmAVtlmiPueCBMKLNFhpOueaUwWeT3POnsY43aLsWhpkDv
         sMDEaA7elE6/B+DqCMlyS68hzyVz9zZwTY5qLLmGaCcV2h8V76wAB3pqPhBWxRnz2Gmb
         9VYaX1iG6dYNnmaS1vcJhq6+Raddgaed3V3SG2vKtl2/R1qdX6o1axO0OPUAM7aIiqrC
         fFYg==
X-Gm-Message-State: ANoB5pmvDh4R+17Z0HH5T6nC+RNyjujjgC1ckbAXW36nEYfo/AsxkmX+
        8zuYk8FJcxDnMY/mSrtDfMBNmA==
X-Google-Smtp-Source: AA0mqf5a5ur58uPnDpwIjYXEwn4PnQ44wkjJwk4UbGX/PChCoGId0YIreHCZd3TM/oH8mIHpTiFUgA==
X-Received: by 2002:a17:90a:2b46:b0:213:aa5f:a026 with SMTP id y6-20020a17090a2b4600b00213aa5fa026mr4652677pjc.243.1668725901245;
        Thu, 17 Nov 2022 14:58:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902710b00b00186bc66d2cbsm1970473pll.73.2022.11.17.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:58:20 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:58:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
Message-ID: <202211171439.CDE720EAD@keescook>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Nov 16, 2022 at 10:16:34AM -0800, Linus Torvalds wrote:
> There _are_ also small random cases too, like get_cmdline(). Maybe
> that counts as ptrace, but the execve() case most definitely does not.

Oh, er, why does get_arg_page() even need FOLL_FORCE? This is writing the
new stack contents to the nascent brpm->vma, which was newly allocated
with VM_STACK_FLAGS, which an arch can override, but they all appear to include
VM_WRITE | VM_MAYWRITE.

-- 
Kees Cook

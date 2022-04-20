Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BDCC433EF
	for <sparclinux@archiver.kernel.org>; Wed, 20 Apr 2022 11:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378259AbiDTLxl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352702AbiDTLxk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 20 Apr 2022 07:53:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9CE1208A;
        Wed, 20 Apr 2022 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e//dGrepWn7jS9BGgfc47xqnbF5iiCNsWca8XJ9Scbo=; b=p9kNFmSNauYxhJ9ue+3HRA2/Sp
        XglgEYEv2K81hgCmNw9FzjRwLCmmriyByATQynMDLwxN+oHlUqiXOXMcgYRBCVLWJ+52fE76Tinhx
        VnNeWeM5BWo8VVwgnqLuV/jHvvLrRr5ZW0/FUCPNO+HNQ8W0qwlHW6+4plkO8+kEDJXWitJTf21q9
        7IyYANdI1o0TwCKpmOY1HKx6kMjnt+H46NWFfPoi0m5UhbgF+UJ9SgeBNw56vkSxMbkBahKnZevRC
        Yt5sl7cnLOOOWpY7CrGjPyogibKPnS17AafKmelx0F6mMt+06bSNNSWhEfVZzEcNCXsZgO1p0bgBQ
        DFSXN5JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh8r4-0076rr-JF; Wed, 20 Apr 2022 11:50:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFF899861A4; Wed, 20 Apr 2022 13:50:40 +0200 (CEST)
Date:   Wed, 20 Apr 2022 13:50:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Deliver SIGTRAP on perf event asynchronously if
 blocked
Message-ID: <20220420115040.GE2731@worktop.programming.kicks-ass.net>
References: <20220404111204.935357-1-elver@google.com>
 <CACT4Y+YiDhmKokuqD3dhtj67HxZpTumiQvvRp35X-sR735qjqQ@mail.gmail.com>
 <CANpmjNPQ9DWzPRx4QWDnZatKGU96xLhb2qN-wgbD84zyZ6_Mig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPQ9DWzPRx4QWDnZatKGU96xLhb2qN-wgbD84zyZ6_Mig@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Apr 12, 2022 at 01:00:00PM +0200, Marco Elver wrote:

> Should there be any further comments, please shout.

Barring objections, I'm going to queue this for perf/core.


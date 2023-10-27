Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71339C25B47
	for <sparclinux@archiver.kernel.org>; Fri, 27 Oct 2023 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjJ0TEF (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 27 Oct 2023 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0TEE (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 27 Oct 2023 15:04:04 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 12:04:01 PDT
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B9116
        for <sparclinux@vger.kernel.org>; Fri, 27 Oct 2023 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=H94qu6peAAnBju0wasBN++vO8+mN5Ue31N0Ays7V/mA=;
        b=J/Cgw0+z7+NZBYC6ZkMj51Qq2FrmMZ9rtpgyj9O1ea+TmIgQtXI/MqP8xsk8PZRRdqWQ8S8NG4F6P
         ffResuz6RrwTyySsjR08GMcDjumRTN/EAvlmBHMQW8nlhIgCAx0F11J4Bcbo3dM6t2QHFheFs8O/Ki
         DJk4ZmIUUhdOyNWZOM+HjTwEjrQJtM0YA3MADg+C/v5bfgzwgMdWn9Lg7wwdEeUpC+K4nFcsTKarII
         8/iTwKftQIK83VBUFTH60vJWVXzP3wFnuMxQARfaEd+S+3cIe6QXjF1beaZi6zLWiKHo+YVCQswjuX
         pm/ed72ZWFN7dmOp/DJ+j0B3KKJ18VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=H94qu6peAAnBju0wasBN++vO8+mN5Ue31N0Ays7V/mA=;
        b=+LC91w5r3b9mVazFIU6nUKgAMU6Yc6/yWiajo56qpzSc7e/w06vd/67PO7LXEH85t8hz4meOHA/0c
         9aXDAKkBg==
X-HalOne-ID: 55cd127b-74f9-11ee-97f1-23968f462fbe
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 55cd127b-74f9-11ee-97f1-23968f462fbe;
        Fri, 27 Oct 2023 18:47:55 +0000 (UTC)
Date:   Fri, 27 Oct 2023 20:47:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc32: fix a braino in fault handling in
 csum_and_copy_..._user()
Message-ID: <20231027184753.GA1048069@ravnborg.org>
References: <20231026021613.GI800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026021613.GI800259@ZenIV>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Al,

On Thu, Oct 26, 2023 at 03:16:13AM +0100, Al Viro wrote:
> Fault handler used to make non-trivial calls, so it needed
> to set a stack frame up.  Used to be
> 	save ... - grab a stack frame, old %o... become %i...
> 	....
> 	ret	- go back to address originally in %o7, currently %i7
> 	 restore - switch to previous stack frame, in delay slot
> Non-trivial calls had been gone since ab5e8b331244 and that code should
> have become
> 	retl	- go back to address in %o7
> 	 clr %o0 - have return value set to 0
> What it had become instead was
> 	ret	- go back to address in %i7 - return address of *caller*
> 	 clr %o0 - have return value set to 0
> which is not good, to put it mildly - we forcibly return 0 from
> csum_and_copy_{from,to}_iter() (which is what the call of that
> thing had been inlined into) and do that without dropping the
> stack frame of said csum_and_copy_..._iter().  Confuses the
> hell out of the caller of csum_and_copy_..._iter(), obviously...

I wonder how you managed to find this? Do you actually use sparc32 these
days?

You could also kill the EX2 define while touchign the file,
it is no longer used after ab5e8b331244.
> 
> Fixes: ab5e8b331244 "sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


> ---
>  arch/sparc/lib/checksum_32.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
> index 84ad709cbecb..66eda40fce36 100644
> --- a/arch/sparc/lib/checksum_32.S
> +++ b/arch/sparc/lib/checksum_32.S
> @@ -453,5 +453,5 @@ ccslow:	cmp	%g1, 0
>   * we only bother with faults on loads... */
>  
>  cc_fault:
> -	ret
> +	retl
>  	 clr	%o0
> -- 
> 2.39.2

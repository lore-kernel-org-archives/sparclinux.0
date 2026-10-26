Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050077;
	b=aBlRwpxnJYc9jJYHW9SuebSHXT2T45WtKMNt7Dsny34IiVDjYtl3CGx9P/j4rSJK/mSH
	 JobiXNt1zBxUOXtf0/Smk8l9sEla1JKhocyG4I0ofzT2GEPweUk/4BKx5af4sCuvfoC1L
	 EE1Qn+2D5GMDm1mjTb3dN37spdTp6v95esCNT2TFXN7edrNzRT9Z8p22OCxPr9Ltrc14C
	 YgxgRsOBhRdD5/Cwjio/TcuCo+d6aRRbf6UlDChxWLg5fIMIBIKn8VQ+sk0Yp6O67XBdo
	 LBw9mLPMWyeoFt6B75VKCfmlCzHq8hxtaRcVfMD0sH1ok0+yum4MvM0tp35ivI1b2WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050077;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type;
	bh=gJHmoDjxHd+OLkeF5r/n1A6K+Yk1TMDwDUl7pBnBkYE=;
	b=AKpP0w149/WtpLJeZ7981vkfhoGYy/2Kc5r039z58Yym9AiN42pT8eAZ5brdDgUBUNlb
	 JSQGGNhWlFO8Zim9wW5fcAkwuc1KuNRHvtOLYAvT5TkPRvn3lCD6HkezjRopR+xdq2lh1
	 CWlxfwRrTTIXB5JRmQEaTjUjFDzj+yVg8V9F1W26hEXgLDaISYG12K/tbKLGLaUDsyXc/
	 rAtqMwGX+aWT3gjv3yfIKd2rV48suQ+qMqzfgVzX0j/9qcatKpr0SWxqJKHO3LH3yW/4r
	 KGfdXxScr0BQY8ZCG7Bj+4ayX9UF3mDHXbdqukmfvmdOqJSOGRI/R+ZmDTSU2YymScg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFB606A31A
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 06EA61003EF55E; Mon, 26 Oct 2026 22:27:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 06AAA1100EDADA;
	Mon, 26 Oct 2026 22:27:54 +0100 (CET)
Date: Mon, 26 Oct 2026 22:27:54 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Stian Halseth <stian@itx.no>
cc: sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
In-Reply-To: <3c24c1f0a16ed4b2f58c3288ae100b48be005c75.camel@itx.no>
Message-ID: <90rrs2po-oq65-pqp4-s7q3-90r5ns5qqn60@vanv.qr>
References: <20261026193421.20404-1-jengelh@inai.de> <3c24c1f0a16ed4b2f58c3288ae100b48be005c75.camel@itx.no>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Monday 2026-10-26 21:16, Stian Halseth wrote:
>
>I ran the walk against the MDs on my T4-1 and T7-1 [..]
>
>Some smaller things:
>
>- Two exec-units have "integer" in their type, and only the first has
>  the L1d arc.

Which two? I have 16 of them.
(If you want, you can send me a directed mail with the contents from
/dev/mdesc and maybe it will enlighten me.)


>  Following the cache arcs of any child, like
>  fill_in_one_cpu() does, avoids that

But we do follow any child. (Well, of all the EUs that were whitelisted
to be interesting types. Going down a "cwq" crypto executor node seemed
unnecessary.)

+       for (unsigned int i = 0; i < ARRAY_SIZE(unit_kinds); ++i) {
+               u64 node = mdesc_find_subobject(mdh, cpu_data(cpuid).mdesc_node,
+                                               "exec-unit", unit_kinds[i]);
+               if (node == -1)
+                       continue;
+               node = mdesc_find_subobject(mdh, node, "cache", NULL);
+               if (node == -1)


>  and the "int" question.

"int" was there in the old code (since commit
f78eae2e6f5d1eb05f76a45486286445b916bd92), I just took it.


>- mdesc_find_subobject() passes NULL and an uninitialized len on if
>  there is no "type" property.

This too was rooted in old code which assumed that "type" always
exists.

->8-
        type = mdesc_get_property(hp, mp, "type", &type_len);

        switch (*level) {
        case 1:
                if (of_find_in_proplist(type, "instn", type_len)) {
-8<-


>- switch (tlb_type) breaks sparc32, since prom_common.c is built there
>  too. Both functions could just live in mdesc.c.
>- Signed-off-by is missing, and a v2 tag with a short changelog would
>  help.

I added one in the first try; that's the one that did not make it to
the list (or my disk). git-send-email is just too stateless for my
taste.

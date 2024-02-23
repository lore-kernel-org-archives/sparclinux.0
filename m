Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D7B66B;
	Fri, 23 Feb 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665360; cv=none; b=YQwhWw33bE95FubajrooL/ouQrdHhLhF0RVVNXDukzhpHhvep3dzAMdogNDoorsNfP2twy4Wt/h/ZMeLFPspYRKxU2+ek8pAiocjeFJPFL+7tHYKm4/QjLQ2wd+SPLpNOscsOWYEC7C9wedo4Fd6mNfUCcRTU3HEzSun5CCTzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665360; c=relaxed/simple;
	bh=WuL1uQewecYalXVHDaYYtlroaae/JXx3HQFuHa4Fq5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qvp23YS7kP8yHwqHLyn7TXBAmL1hV9lr2ReFTd8or5RG+ZPio9PORYiAvciOBVxT7MzOUFTGuX0srNbgbHz7jadxPkPg++QJjRvcFv+Aidv7v+T3VbLOu2rWzsX9vgeDmUEbkbZzciOgjnnfR5INyrDhWKN/MV6MH0SBzFOU5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K4pZXLcE/2qx7/60xUGjLqbdHGX9Oq/cAHz4EffVmhs=; b=TJTibySTb/nEdkBxr6pXorTJu+
	fNpbiFnNAYVjJGi7zJhNEEXqDIz+80ctyjvWohVwAPJjzL0cDEYIWsC/4APSDdDdIBQiRkejhu6f0
	UlVuvJKEgD+nhCN1KsBi0PFKKwnQcgVTeek5enfinKeijrYa1W6hfcQFduMbJ2WudW/npir7QWfkg
	Zk4U5xnp7Mf5bluvnPZ/sRoC5fYs55QWsU6BOceIrwg+OwOod9YTPFrpnRIWxqvidI7IUWBOjgPby
	oRJFnec6i8kDAA/ADjNwycJngFEpqdmJ4TlRslJDqiZ2LAzEtcS0Lmk8OP228K9bwmUUwH58aC8H/
	5alvaMtA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdNuF-00000007xVV-3zqp;
	Fri, 23 Feb 2024 05:15:37 +0000
Message-ID: <4c4e2845-c7a8-4d0b-aa4a-7c5e3399b3dc@infradead.org>
Date: Thu, 22 Feb 2024 21:15:28 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sparclinux <sparclinux@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andreas Larsson <andreas@gaisler.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: sparc: patch to fix parport_pc build on 32-bit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andreas,

Please pick up this patch from June/2023. I have already replied to
the patch with:

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

and I just rechecked it on linux-next-20240223 to make sure that it
builds cleanly. It does; however, there is one trivial merge warning:

patching file arch/sparc/include/asm/parport.h
Hunk #1 succeeded at 20 (offset 1 line).
Hunk #2 succeeded at 252 (offset 1 line).

The patch:
https://lore.kernel.org/lkml/alpine.DEB.2.21.2306190121540.14084@angie.orcam.me.uk/


Thank you.
-- 
#Randy

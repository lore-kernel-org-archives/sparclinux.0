Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B079C8
	for <sparclinux@vger.kernel.org>; Sat,  2 Mar 2024 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354524; cv=none; b=VRYmnoM5PPcjrz9fqkl7lQsEqn2DIF11Bo71roqwIz45qiFYhH1ywuvVdIB+rNQpc9htnGWbelyPrCbZUSOiXXP3q5SWJF1PiiH68QBItkkLrRa1gitFCPzCxDj012rF9t8bQtPBTjo0TumBmJB4jFbN7HT+/4OCfY2/U4Wl1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354524; c=relaxed/simple;
	bh=MXkZbHcAYrMQokVasZjqqARe/8ZeQSSJWSrnamcbMeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTdeyvtQEcTGJdIde9iaEXwIuFuLlGhHrtwHVdzIAAOmHj393v72MBHVsqdiIKeOHnretprwMxdsW1OTmtzvjkLzT5ctbGLKJyL00XiJ0SjiIj0pZMLWvJ/5GmCRyxK+whbtaC2d0FJd+nQfiyRF+x7r0hdDRL1FqHDMooLijJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNZVTDW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNZVTDW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C11C433F1;
	Sat,  2 Mar 2024 04:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709354524;
	bh=MXkZbHcAYrMQokVasZjqqARe/8ZeQSSJWSrnamcbMeo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pNZVTDW052untAoMM3fIhVi1TOCMARX2epBZqScT5fbxuxftHho8z9ni2Lj573IYY
	 y9jtFKgeNkX7cv8N716ImNE4JMDY0fAMa8s+cuC99ingylOInZl94TBbrXBN10q16/
	 KGr33enxHu9Ak3wLKsvjgPykmD0jIkRNwtq2apjndnTLf5LUg3FKxw47ir6t1pO8QY
	 giKlulyVyiaEt/tL7T37d6hGxplSngTJzcuTuWyslnXtBpwiZyPhk0lFGsMC2+4pLr
	 fTJfdJU02wV3fQF0SFfW5NS9zijWlFQU9t6EZSXmxZMHWx6zaDrM/wNMfh5VwcF3Jt
	 Z2KE9OzM9wHbA==
Message-ID: <5132da26-7c2a-4269-aa71-17315593dbde@kernel.org>
Date: Fri, 1 Mar 2024 20:42:01 -0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2.1 01/12] ARC: Use initializer for struct
 vm_unmapped_area_info
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 broonie@kernel.org, dave.hansen@linux.intel.com, debug@rivosinc.com,
 hpa@zytor.com, keescook@chromium.org, kirill.shutemov@linux.intel.com,
 luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
 sparclinux@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
 Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20240302001714.674091-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/1/24 16:17, Rick Edgecombe wrote:
> Future changes will need to add a new member to struct
> vm_unmapped_area_info. This would cause trouble for any call site that
> doesn't initialize the struct. Currently every caller sets each field
> manually, so if new fields are added they will be unitialized and the core
> code parsing the struct will see garbage in the new field.
>
> It could be possible to initialize the new field manually to 0 at each
> call site. This and a couple other options were discussed, and the
> consensus (see links) was that in general the best way to accomplish this
> would be via static initialization with designated field initiators.
> Having some struct vm_unmapped_area_info instances not zero initialized
> will put those sites at risk of feeding garbage into vm_unmapped_area() if
> the convention is to zero initialize the struct and any new field addition
> misses a call site that initializes each field manually.
>
> It could be possible to leave the code mostly untouched, and just change
> the line:
> struct vm_unmapped_area_info info
> to:
> struct vm_unmapped_area_info info = {};
>
> However, that would leave cleanup for the fields that are manually set
> to zero, as it would no longer be required.
>
> So to be reduce the chance of bugs via uninitialized fields, instead
> simply continue the process to initialize the struct this way tree wide.
> This will zero any unspecified members. Move the field initializers to the
> struct declaration when they are known at that time. Leave the fields out
> that were manually initialized to zero, as this would be redundant for
> designated initializers.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-snps-arc@lists.infradead.org
> Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
> Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/

LGTM.

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet

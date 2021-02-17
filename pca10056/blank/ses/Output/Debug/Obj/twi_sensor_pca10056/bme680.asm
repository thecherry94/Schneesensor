	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"bme680.c"
	.text
.Ltext0:
	.section	.text.bme680_init,"ax",%progbits
	.align	1
	.global	bme680_init
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_init, %function
bme680_init:
.LFB0:
	.file 1 "C:\\nordic\\nRF5_SDK_17.0.2_d674dde\\own_projects\\eigene\\twi_sensor2\\lib\\sensor\\snow_bme680\\bme680.c"
	.loc 1 279 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI0:
	sub	sp, sp, #20
.LCFI1:
	str	r0, [sp, #4]
	.loc 1 283 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 284 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L2
	.loc 1 286 10
	ldr	r0, [sp, #4]
	bl	bme680_soft_reset
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 287 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L2
	.loc 1 288 11
	ldr	r1, [sp, #4]
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #208
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 289 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L2
	.loc 1 290 12
	ldr	r3, [sp, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 290 8
	cmp	r3, #97
	bne	.L3
	.loc 1 292 13
	ldr	r0, [sp, #4]
	bl	get_calib_data
	mov	r3, r0
	strb	r3, [sp, #15]
	b	.L2
.L3:
	.loc 1 294 11
	movs	r3, #253
	strb	r3, [sp, #15]
.L2:
	.loc 1 300 9
	ldrsb	r3, [sp, #15]
	.loc 1 301 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI2:
	@ sp needed
	ldr	pc, [sp], #4
.LFE0:
	.size	bme680_init, .-bme680_init
	.section	.text.bme680_get_regs,"ax",%progbits
	.align	1
	.global	bme680_get_regs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_get_regs, %function
bme680_get_regs:
.LFB1:
	.loc 1 307 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI3:
	sub	sp, sp, #24
.LCFI4:
	str	r1, [sp, #8]
	str	r3, [sp, #4]
	mov	r3, r0
	strb	r3, [sp, #15]
	mov	r3, r2	@ movhi
	strh	r3, [sp, #12]	@ movhi
	.loc 1 311 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #23]
	.loc 1 312 5
	ldrsb	r3, [sp, #23]
	cmp	r3, #0
	bne	.L6
	.loc 1 313 10
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 313 6
	cmp	r3, #0
	bne	.L7
	.loc 1 315 11
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	ldr	r1, [sp, #4]
	mov	r0, r3
	bl	set_mem_page
	mov	r3, r0
	strb	r3, [sp, #23]
	.loc 1 316 7
	ldrsb	r3, [sp, #23]
	cmp	r3, #0
	bne	.L7
	.loc 1 317 14
	ldrb	r3, [sp, #15]
	orn	r3, r3, #127
	strb	r3, [sp, #15]
.L7:
	.loc 1 319 22
	ldr	r3, [sp, #4]
	ldr	r4, [r3, #72]
	.loc 1 319 19
	ldr	r3, [sp, #4]
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	ldrh	r3, [sp, #12]
	ldrb	r1, [sp, #15]	@ zero_extendqisi2
	ldr	r2, [sp, #8]
	blx	r4
.LVL0:
	mov	r3, r0
	mov	r2, r3
	.loc 1 319 17
	ldr	r3, [sp, #4]
	strb	r2, [r3, #84]
	.loc 1 320 10
	ldr	r3, [sp, #4]
	ldrsb	r3, [r3, #84]
	.loc 1 320 6
	cmp	r3, #0
	beq	.L6
	.loc 1 321 9
	movs	r3, #254
	strb	r3, [sp, #23]
.L6:
	.loc 1 324 9
	ldrsb	r3, [sp, #23]
	.loc 1 325 1
	mov	r0, r3
	add	sp, sp, #24
.LCFI5:
	@ sp needed
	pop	{r4, pc}
.LFE1:
	.size	bme680_get_regs, .-bme680_get_regs
	.section	.text.bme680_set_regs,"ax",%progbits
	.align	1
	.global	bme680_set_regs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_set_regs, %function
bme680_set_regs:
.LFB2:
	.loc 1 332 1
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
.LCFI6:
	sub	sp, sp, #68
.LCFI7:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r3, [sp]
	mov	r3, r2
	strb	r3, [sp, #7]
	.loc 1 335 10
	movs	r3, #0
	str	r3, [sp, #20]
	add	r3, sp, #24
	movs	r2, #36
	movs	r1, #0
	mov	r0, r3
	bl	memset
	.loc 1 339 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #63]
	.loc 1 340 5
	ldrsb	r3, [sp, #63]
	cmp	r3, #0
	bne	.L10
	.loc 1 341 6
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L11
	.loc 1 341 17 discriminator 1
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	cmp	r3, #19
	bhi	.L11
	.loc 1 343 15
	movs	r3, #0
	strh	r3, [sp, #60]	@ movhi
	.loc 1 343 4
	b	.L12
.L15:
	.loc 1 344 12
	ldr	r3, [sp]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 344 8
	cmp	r3, #0
	bne	.L13
	.loc 1 346 34
	ldrh	r3, [sp, #60]
	ldr	r2, [sp, #12]
	add	r3, r3, r2
	.loc 1 346 13
	ldrb	r3, [r3]	@ zero_extendqisi2
	ldr	r1, [sp]
	mov	r0, r3
	bl	set_mem_page
	mov	r3, r0
	strb	r3, [sp, #63]
	.loc 1 347 38
	ldrh	r3, [sp, #60]
	ldr	r2, [sp, #12]
	add	r3, r3, r2
	ldrb	r2, [r3]	@ zero_extendqisi2
	.loc 1 347 18
	ldrh	r3, [sp, #60]
	lsls	r3, r3, #1
	.loc 1 347 46
	and	r2, r2, #127
	uxtb	r2, r2
	.loc 1 347 28
	add	r1, sp, #64
	add	r3, r3, r1
	strb	r2, [r3, #-44]
	b	.L14
.L13:
	.loc 1 349 38
	ldrh	r3, [sp, #60]
	ldr	r2, [sp, #12]
	add	r2, r2, r3
	.loc 1 349 18
	ldrh	r3, [sp, #60]
	lsls	r3, r3, #1
	.loc 1 349 38
	ldrb	r2, [r2]	@ zero_extendqisi2
	.loc 1 349 28
	add	r1, sp, #64
	add	r3, r3, r1
	strb	r2, [r3, #-44]
.L14:
	.loc 1 351 41 discriminator 2
	ldrh	r3, [sp, #60]
	ldr	r2, [sp, #8]
	add	r2, r2, r3
	.loc 1 351 17 discriminator 2
	ldrh	r3, [sp, #60]
	lsls	r3, r3, #1
	.loc 1 351 26 discriminator 2
	adds	r3, r3, #1
	.loc 1 351 41 discriminator 2
	ldrb	r2, [r2]	@ zero_extendqisi2
	.loc 1 351 31 discriminator 2
	add	r1, sp, #64
	add	r3, r3, r1
	strb	r2, [r3, #-44]
	.loc 1 343 38 discriminator 2
	ldrh	r3, [sp, #60]
	adds	r3, r3, #1
	strh	r3, [sp, #60]	@ movhi
.L12:
	.loc 1 343 26 discriminator 1
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 343 4 discriminator 1
	ldrh	r2, [sp, #60]
	cmp	r2, r3
	bcc	.L15
	.loc 1 354 7
	ldrsb	r3, [sp, #63]
	cmp	r3, #0
	bne	.L18
	.loc 1 355 24
	ldr	r3, [sp]
	ldr	r4, [r3, #76]
	.loc 1 355 21
	ldr	r3, [sp]
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	ldrb	r1, [sp, #20]	@ zero_extendqisi2
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	uxth	r3, r3
	lsls	r3, r3, #1
	uxth	r3, r3
	subs	r3, r3, #1
	uxth	r5, r3
	add	r3, sp, #20
	adds	r2, r3, #1
	mov	r3, r5
	blx	r4
.LVL1:
	mov	r3, r0
	mov	r2, r3
	.loc 1 355 19
	ldr	r3, [sp]
	strb	r2, [r3, #84]
	.loc 1 356 12
	ldr	r3, [sp]
	ldrsb	r3, [r3, #84]
	.loc 1 356 8
	cmp	r3, #0
	beq	.L18
	.loc 1 357 11
	movs	r3, #254
	strb	r3, [sp, #63]
	.loc 1 354 7
	b	.L18
.L11:
	.loc 1 360 9
	movs	r3, #252
	strb	r3, [sp, #63]
	b	.L10
.L18:
	.loc 1 354 7
	nop
.L10:
	.loc 1 364 9
	ldrsb	r3, [sp, #63]
	.loc 1 365 1
	mov	r0, r3
	add	sp, sp, #68
.LCFI8:
	@ sp needed
	pop	{r4, r5, pc}
.LFE2:
	.size	bme680_set_regs, .-bme680_set_regs
	.section	.text.bme680_soft_reset,"ax",%progbits
	.align	1
	.global	bme680_soft_reset
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_soft_reset, %function
bme680_soft_reset:
.LFB3:
	.loc 1 371 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI9:
	sub	sp, sp, #20
.LCFI10:
	str	r0, [sp, #4]
	.loc 1 373 10
	movs	r3, #224
	strb	r3, [sp, #14]
	.loc 1 375 10
	movs	r3, #182
	strb	r3, [sp, #13]
	.loc 1 378 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 379 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L20
	.loc 1 380 10
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 380 6
	cmp	r3, #0
	bne	.L21
	.loc 1 381 11
	ldr	r0, [sp, #4]
	bl	get_mem_page
	mov	r3, r0
	strb	r3, [sp, #15]
.L21:
	.loc 1 384 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L20
	.loc 1 385 11
	add	r1, sp, #13
	add	r0, sp, #14
	ldr	r3, [sp, #4]
	movs	r2, #1
	bl	bme680_set_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 387 7
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #80]
	.loc 1 387 4
	movs	r0, #10
	blx	r3
.LVL2:
	.loc 1 389 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L20
	.loc 1 391 12
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 391 8
	cmp	r3, #0
	bne	.L20
	.loc 1 392 13
	ldr	r0, [sp, #4]
	bl	get_mem_page
	mov	r3, r0
	strb	r3, [sp, #15]
.L20:
	.loc 1 397 9
	ldrsb	r3, [sp, #15]
	.loc 1 398 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI11:
	@ sp needed
	ldr	pc, [sp], #4
.LFE3:
	.size	bme680_soft_reset, .-bme680_soft_reset
	.section	.text.bme680_set_sensor_settings,"ax",%progbits
	.align	1
	.global	bme680_set_sensor_settings
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_set_sensor_settings, %function
bme680_set_sensor_settings:
.LFB4:
	.loc 1 405 1
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI12:
	sub	sp, sp, #36
.LCFI13:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	.loc 1 408 10
	movs	r3, #0
	strb	r3, [sp, #27]
	.loc 1 409 10
	movs	r3, #0
	strb	r3, [sp, #30]
	.loc 1 410 10
	movs	r3, #0
	str	r3, [sp, #20]
	movs	r3, #0
	strh	r3, [sp, #24]	@ movhi
	.loc 1 411 10
	movs	r3, #0
	str	r3, [sp, #12]
	movs	r3, #0
	strh	r3, [sp, #16]	@ movhi
	.loc 1 412 10
	ldr	r3, [sp]
	ldrb	r3, [r3, #68]
	strb	r3, [sp, #29]
	.loc 1 415 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 416 5
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L24
	.loc 1 417 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #8
	.loc 1 417 6
	cmp	r3, #0
	beq	.L25
	.loc 1 418 11
	ldr	r0, [sp]
	bl	set_gas_config
	mov	r3, r0
	strb	r3, [sp, #31]
.L25:
	.loc 1 420 19
	ldr	r3, [sp]
	movs	r2, #0
	strb	r2, [r3, #68]
	.loc 1 421 6
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L26
	.loc 1 422 11
	ldr	r0, [sp]
	bl	bme680_set_sensor_mode
	mov	r3, r0
	strb	r3, [sp, #31]
.L26:
	.loc 1 425 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #16
	.loc 1 425 6
	cmp	r3, #0
	beq	.L27
	.loc 1 426 11
	ldr	r3, [sp]
	add	r0, r3, #59
	ldr	r3, [sp]
	movs	r2, #7
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 427 13
	movs	r3, #117
	strb	r3, [sp, #28]
	.loc 1 429 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L28
	.loc 1 430 12
	add	r1, sp, #27
	ldrb	r0, [sp, #28]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L28:
	.loc 1 432 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #16
	.loc 1 432 7
	cmp	r3, #0
	beq	.L29
	.loc 1 433 12
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #28
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #59]	@ zero_extendqisi2
	lsls	r3, r3, #2
	uxtb	r3, r3
	and	r3, r3, #28
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 433 10
	strb	r3, [sp, #27]
.L29:
	.loc 1 435 13
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 435 21
	add	r2, sp, #32
	add	r3, r3, r2
	ldrb	r2, [sp, #28]
	strb	r2, [r3, #-12]
	.loc 1 436 14
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 436 22
	ldrb	r2, [sp, #27]	@ zero_extendqisi2
	add	r1, sp, #32
	add	r3, r3, r1
	strb	r2, [r3, #-20]
	.loc 1 437 9
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [sp, #30]
.L27:
	.loc 1 441 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #32
	.loc 1 441 6
	cmp	r3, #0
	beq	.L30
	.loc 1 442 11
	ldr	r3, [sp]
	add	r0, r3, #61
	ldr	r3, [sp]
	movs	r2, #8
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 444 13
	movs	r3, #112
	strb	r3, [sp, #28]
	.loc 1 446 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L31
	.loc 1 447 12
	add	r1, sp, #27
	ldrb	r0, [sp, #28]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L31:
	.loc 1 448 11
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #8
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #61]	@ zero_extendqisi2
	and	r3, r3, #8
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 448 9
	strb	r3, [sp, #27]
	.loc 1 450 13
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 450 21
	add	r2, sp, #32
	add	r3, r3, r2
	ldrb	r2, [sp, #28]
	strb	r2, [r3, #-12]
	.loc 1 451 14
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 451 22
	ldrb	r2, [sp, #27]	@ zero_extendqisi2
	add	r1, sp, #32
	add	r3, r3, r1
	strb	r2, [r3, #-20]
	.loc 1 452 9
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [sp, #30]
.L30:
	.loc 1 456 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #3
	.loc 1 456 6
	cmp	r3, #0
	beq	.L32
	.loc 1 457 11
	ldr	r3, [sp]
	add	r0, r3, #57
	ldr	r3, [sp]
	movs	r2, #5
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 458 13
	movs	r3, #116
	strb	r3, [sp, #28]
	.loc 1 460 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L33
	.loc 1 461 12
	add	r1, sp, #27
	ldrb	r0, [sp, #28]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L33:
	.loc 1 463 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #1
	.loc 1 463 7
	cmp	r3, #0
	beq	.L34
	.loc 1 464 12
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	and	r3, r3, #31
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #57]	@ zero_extendqisi2
	lsls	r3, r3, #5
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 464 10
	strb	r3, [sp, #27]
.L34:
	.loc 1 466 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #2
	.loc 1 466 7
	cmp	r3, #0
	beq	.L35
	.loc 1 467 12
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #28
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #58]	@ zero_extendqisi2
	lsls	r3, r3, #2
	uxtb	r3, r3
	and	r3, r3, #28
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 467 10
	strb	r3, [sp, #27]
.L35:
	.loc 1 469 13
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 469 21
	add	r2, sp, #32
	add	r3, r3, r2
	ldrb	r2, [sp, #28]
	strb	r2, [r3, #-12]
	.loc 1 470 14
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 470 22
	ldrb	r2, [sp, #27]	@ zero_extendqisi2
	add	r1, sp, #32
	add	r3, r3, r1
	strb	r2, [r3, #-20]
	.loc 1 471 9
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [sp, #30]
.L32:
	.loc 1 475 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #4
	.loc 1 475 6
	cmp	r3, #0
	beq	.L36
	.loc 1 476 11
	ldr	r3, [sp]
	add	r0, r3, #56
	ldr	r3, [sp]
	movs	r2, #5
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 477 13
	movs	r3, #114
	strb	r3, [sp, #28]
	.loc 1 479 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L37
	.loc 1 480 12
	add	r1, sp, #27
	ldrb	r0, [sp, #28]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L37:
	.loc 1 481 11
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #7
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #56]	@ zero_extendqisi2
	and	r3, r3, #7
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 481 9
	strb	r3, [sp, #27]
	.loc 1 483 13
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 483 21
	add	r2, sp, #32
	add	r3, r3, r2
	ldrb	r2, [sp, #28]
	strb	r2, [r3, #-12]
	.loc 1 484 14
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 484 22
	ldrb	r2, [sp, #27]	@ zero_extendqisi2
	add	r1, sp, #32
	add	r3, r3, r1
	strb	r2, [r3, #-20]
	.loc 1 485 9
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [sp, #30]
.L36:
	.loc 1 489 24
	ldrh	r3, [sp, #6]
	and	r3, r3, #192
	.loc 1 489 6
	cmp	r3, #0
	beq	.L38
	.loc 1 490 11
	ldr	r3, [sp]
	add	r0, r3, #62
	ldr	r3, [sp]
	movs	r2, #1
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
	.loc 1 492 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L39
	.loc 1 494 12
	ldr	r3, [sp]
	add	r0, r3, #60
	ldr	r3, [sp]
	movs	r2, #10
	movs	r1, #0
	bl	boundary_check
	mov	r3, r0
	strb	r3, [sp, #31]
.L39:
	.loc 1 498 13
	movs	r3, #113
	strb	r3, [sp, #28]
	.loc 1 500 7
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L40
	.loc 1 501 12
	add	r1, sp, #27
	ldrb	r0, [sp, #28]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L40:
	.loc 1 503 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #64
	.loc 1 503 7
	cmp	r3, #0
	beq	.L41
	.loc 1 504 12
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #16
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #62]	@ zero_extendqisi2
	lsls	r3, r3, #4
	uxtb	r3, r3
	and	r3, r3, #16
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 504 10
	strb	r3, [sp, #27]
.L41:
	.loc 1 506 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #128
	.loc 1 506 7
	cmp	r3, #0
	beq	.L42
	.loc 1 507 12
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	bic	r3, r3, #15
	uxtb	r2, r3
	ldr	r3, [sp]
	ldrb	r3, [r3, #60]	@ zero_extendqisi2
	and	r3, r3, #15
	uxtb	r3, r3
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 507 10
	strb	r3, [sp, #27]
.L42:
	.loc 1 509 13
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 509 21
	add	r2, sp, #32
	add	r3, r3, r2
	ldrb	r2, [sp, #28]
	strb	r2, [r3, #-12]
	.loc 1 510 14
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	.loc 1 510 22
	ldrb	r2, [sp, #27]	@ zero_extendqisi2
	add	r1, sp, #32
	add	r3, r3, r1
	strb	r2, [r3, #-20]
	.loc 1 511 9
	ldrb	r3, [sp, #30]	@ zero_extendqisi2
	adds	r3, r3, #1
	strb	r3, [sp, #30]
.L38:
	.loc 1 514 6
	ldrsb	r3, [sp, #31]
	cmp	r3, #0
	bne	.L43
	.loc 1 515 11
	ldrb	r2, [sp, #30]	@ zero_extendqisi2
	add	r1, sp, #12
	add	r0, sp, #20
	ldr	r3, [sp]
	bl	bme680_set_regs
	mov	r3, r0
	strb	r3, [sp, #31]
.L43:
	.loc 1 518 19
	ldr	r3, [sp]
	ldrb	r2, [sp, #29]
	strb	r2, [r3, #68]
.L24:
	.loc 1 521 9
	ldrsb	r3, [sp, #31]
	.loc 1 522 1
	mov	r0, r3
	add	sp, sp, #36
.LCFI14:
	@ sp needed
	ldr	pc, [sp], #4
.LFE4:
	.size	bme680_set_sensor_settings, .-bme680_set_sensor_settings
	.section	.text.bme680_get_sensor_settings,"ax",%progbits
	.align	1
	.global	bme680_get_sensor_settings
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_get_sensor_settings, %function
bme680_get_sensor_settings:
.LFB5:
	.loc 1 529 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI15:
	sub	sp, sp, #20
.LCFI16:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	.loc 1 532 10
	movs	r3, #112
	strb	r3, [sp, #14]
	.loc 1 533 10
	movs	r3, #0
	str	r3, [sp, #8]
	movs	r3, #0
	strh	r3, [sp, #12]	@ movhi
	.loc 1 536 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 537 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L46
	.loc 1 538 10
	add	r1, sp, #8
	ldrb	r0, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp]
	movs	r2, #6
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 540 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L47
	.loc 1 541 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #8
	.loc 1 541 7
	cmp	r3, #0
	beq	.L48
	.loc 1 542 12
	ldr	r0, [sp]
	bl	get_gas_config
	mov	r3, r0
	strb	r3, [sp, #15]
.L48:
	.loc 1 545 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #16
	.loc 1 545 7
	cmp	r3, #0
	beq	.L49
	.loc 1 546 28
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	lsrs	r3, r3, #2
	uxtb	r3, r3
	and	r3, r3, #7
	uxtb	r2, r3
	.loc 1 546 26
	ldr	r3, [sp]
	strb	r2, [r3, #59]
.L49:
	.loc 1 549 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #3
	.loc 1 549 7
	cmp	r3, #0
	beq	.L50
	.loc 1 550 29
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	lsrs	r3, r3, #5
	uxtb	r2, r3
	.loc 1 550 27
	ldr	r3, [sp]
	strb	r2, [r3, #57]
	.loc 1 551 29
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	lsrs	r3, r3, #2
	uxtb	r3, r3
	and	r3, r3, #7
	uxtb	r2, r3
	.loc 1 551 27
	ldr	r3, [sp]
	strb	r2, [r3, #58]
.L50:
	.loc 1 554 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #4
	.loc 1 554 7
	cmp	r3, #0
	beq	.L51
	.loc 1 555 28
	ldrb	r3, [sp, #10]	@ zero_extendqisi2
	and	r3, r3, #7
	uxtb	r2, r3
	.loc 1 555 26
	ldr	r3, [sp]
	strb	r2, [r3, #56]
.L51:
	.loc 1 559 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #32
	.loc 1 559 7
	cmp	r3, #0
	beq	.L52
	.loc 1 560 32
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	and	r3, r3, #8
	uxtb	r2, r3
	.loc 1 560 30
	ldr	r3, [sp]
	strb	r2, [r3, #61]
.L52:
	.loc 1 563 25
	ldrh	r3, [sp, #6]
	and	r3, r3, #192
	.loc 1 563 7
	cmp	r3, #0
	beq	.L47
	.loc 1 564 29
	ldrb	r3, [sp, #9]	@ zero_extendqisi2
	and	r3, r3, #15
	uxtb	r2, r3
	.loc 1 564 27
	ldr	r3, [sp]
	strb	r2, [r3, #60]
	.loc 1 566 29
	ldrb	r3, [sp, #9]	@ zero_extendqisi2
	lsrs	r3, r3, #4
	uxtb	r3, r3
	and	r3, r3, #1
	uxtb	r2, r3
	.loc 1 566 27
	ldr	r3, [sp]
	strb	r2, [r3, #62]
	b	.L47
.L46:
	.loc 1 571 8
	movs	r3, #255
	strb	r3, [sp, #15]
.L47:
	.loc 1 574 9
	ldrsb	r3, [sp, #15]
	.loc 1 575 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI17:
	@ sp needed
	ldr	pc, [sp], #4
.LFE5:
	.size	bme680_get_sensor_settings, .-bme680_get_sensor_settings
	.section	.text.bme680_set_sensor_mode,"ax",%progbits
	.align	1
	.global	bme680_set_sensor_mode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_set_sensor_mode, %function
bme680_set_sensor_mode:
.LFB6:
	.loc 1 581 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI18:
	sub	sp, sp, #20
.LCFI19:
	str	r0, [sp, #4]
	.loc 1 584 10
	movs	r3, #0
	strb	r3, [sp, #14]
	.loc 1 585 10
	movs	r3, #116
	strb	r3, [sp, #12]
	.loc 1 588 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 589 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L55
.L57:
	.loc 1 592 11
	add	r1, sp, #13
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #116
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 593 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L56
	.loc 1 595 30
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 595 14
	and	r3, r3, #3
	strb	r3, [sp, #14]
	.loc 1 597 8
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L56
	.loc 1 598 34
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	bic	r3, r3, #3
	uxtb	r3, r3
	.loc 1 598 19
	strb	r3, [sp, #13]
	.loc 1 599 13
	add	r1, sp, #13
	add	r0, sp, #12
	ldr	r3, [sp, #4]
	movs	r2, #1
	bl	bme680_set_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 600 9
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #80]
	.loc 1 600 6
	movs	r0, #10
	blx	r3
.LVL3:
.L56:
	.loc 1 603 3
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L57
	.loc 1 606 10
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #68]	@ zero_extendqisi2
	.loc 1 606 6
	cmp	r3, #0
	beq	.L55
	.loc 1 607 33
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	bic	r3, r3, #3
	uxtb	r2, r3
	.loc 1 607 59
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #68]	@ zero_extendqisi2
	.loc 1 607 72
	and	r3, r3, #3
	uxtb	r3, r3
	.loc 1 607 53
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 607 17
	strb	r3, [sp, #13]
	.loc 1 608 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L55
	.loc 1 609 12
	add	r1, sp, #13
	add	r0, sp, #12
	ldr	r3, [sp, #4]
	movs	r2, #1
	bl	bme680_set_regs
	mov	r3, r0
	strb	r3, [sp, #15]
.L55:
	.loc 1 613 9
	ldrsb	r3, [sp, #15]
	.loc 1 614 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI20:
	@ sp needed
	ldr	pc, [sp], #4
.LFE6:
	.size	bme680_set_sensor_mode, .-bme680_set_sensor_mode
	.section	.text.bme680_get_sensor_mode,"ax",%progbits
	.align	1
	.global	bme680_get_sensor_mode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_get_sensor_mode, %function
bme680_get_sensor_mode:
.LFB7:
	.loc 1 620 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI21:
	sub	sp, sp, #20
.LCFI22:
	str	r0, [sp, #4]
	.loc 1 625 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 626 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L60
	.loc 1 627 10
	add	r1, sp, #14
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #116
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 629 26
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	and	r3, r3, #3
	uxtb	r2, r3
	.loc 1 629 19
	ldr	r3, [sp, #4]
	strb	r2, [r3, #68]
.L60:
	.loc 1 632 9
	ldrsb	r3, [sp, #15]
	.loc 1 633 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI23:
	@ sp needed
	ldr	pc, [sp], #4
.LFE7:
	.size	bme680_get_sensor_mode, .-bme680_get_sensor_mode
	.section .rodata
	.align	2
.LC2:
	.ascii	"\000\001\002\004\010\020"
	.section	.text.bme680_set_profile_dur,"ax",%progbits
	.align	1
	.global	bme680_set_profile_dur
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_set_profile_dur, %function
bme680_set_profile_dur:
.LFB8:
	.loc 1 639 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #24
.LCFI24:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	.loc 1 642 10
	ldr	r2, .L63
	add	r3, sp, #8
	ldm	r2, {r0, r1}
	str	r0, [r3]
	adds	r3, r3, #4
	strh	r1, [r3]	@ movhi
	.loc 1 644 47
	ldr	r3, [sp]
	ldrb	r3, [r3, #57]	@ zero_extendqisi2
	.loc 1 644 33
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	.loc 1 644 14
	str	r3, [sp, #20]
	.loc 1 645 48
	ldr	r3, [sp]
	ldrb	r3, [r3, #58]	@ zero_extendqisi2
	.loc 1 645 34
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 645 14
	ldr	r3, [sp, #20]
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 646 48
	ldr	r3, [sp]
	ldrb	r3, [r3, #56]	@ zero_extendqisi2
	.loc 1 646 34
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 646 14
	ldr	r3, [sp, #20]
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 649 10
	ldr	r3, [sp, #20]
	movw	r2, #1963
	mul	r3, r2, r3
	str	r3, [sp, #16]
	.loc 1 650 10
	ldr	r3, [sp, #16]
	addw	r3, r3, #1908
	str	r3, [sp, #16]
	.loc 1 651 10
	ldr	r3, [sp, #16]
	addw	r3, r3, #2385
	str	r3, [sp, #16]
	.loc 1 652 10
	ldr	r3, [sp, #16]
	add	r3, r3, #500
	str	r3, [sp, #16]
	.loc 1 653 10
	ldr	r3, [sp, #16]
	ldr	r2, .L63+4
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #16]
	.loc 1 655 10
	ldr	r3, [sp, #16]
	adds	r3, r3, #1
	str	r3, [sp, #16]
	.loc 1 657 39
	ldr	r3, [sp, #16]
	uxth	r3, r3
	.loc 1 657 37
	ldrh	r2, [sp, #6]	@ movhi
	subs	r3, r2, r3
	uxth	r2, r3
	.loc 1 657 26
	ldr	r3, [sp]
	strh	r2, [r3, #66]	@ movhi
	.loc 1 658 1
	nop
	add	sp, sp, #24
.LCFI25:
	@ sp needed
	bx	lr
.L64:
	.align	2
.L63:
	.word	.LC2
	.word	274877907
.LFE8:
	.size	bme680_set_profile_dur, .-bme680_set_profile_dur
	.section	.text.bme680_get_profile_dur,"ax",%progbits
	.align	1
	.global	bme680_get_profile_dur
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_get_profile_dur, %function
bme680_get_profile_dur:
.LFB9:
	.loc 1 664 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #24
.LCFI26:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 667 10
	ldr	r2, .L68
	add	r3, sp, #8
	ldm	r2, {r0, r1}
	str	r0, [r3]
	adds	r3, r3, #4
	strh	r1, [r3]	@ movhi
	.loc 1 669 47
	ldr	r3, [sp]
	ldrb	r3, [r3, #57]	@ zero_extendqisi2
	.loc 1 669 33
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	.loc 1 669 14
	str	r3, [sp, #20]
	.loc 1 670 48
	ldr	r3, [sp]
	ldrb	r3, [r3, #58]	@ zero_extendqisi2
	.loc 1 670 34
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 670 14
	ldr	r3, [sp, #20]
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 671 48
	ldr	r3, [sp]
	ldrb	r3, [r3, #56]	@ zero_extendqisi2
	.loc 1 671 34
	add	r2, sp, #24
	add	r3, r3, r2
	ldrb	r3, [r3, #-16]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 671 14
	ldr	r3, [sp, #20]
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 674 10
	ldr	r3, [sp, #20]
	movw	r2, #1963
	mul	r3, r2, r3
	str	r3, [sp, #16]
	.loc 1 675 10
	ldr	r3, [sp, #16]
	addw	r3, r3, #1908
	str	r3, [sp, #16]
	.loc 1 676 10
	ldr	r3, [sp, #16]
	addw	r3, r3, #2385
	str	r3, [sp, #16]
	.loc 1 677 10
	ldr	r3, [sp, #16]
	add	r3, r3, #500
	str	r3, [sp, #16]
	.loc 1 678 10
	ldr	r3, [sp, #16]
	ldr	r2, .L68+4
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #16]
	.loc 1 680 10
	ldr	r3, [sp, #16]
	adds	r3, r3, #1
	str	r3, [sp, #16]
	.loc 1 682 14
	ldr	r3, [sp, #16]
	uxth	r2, r3
	.loc 1 682 12
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 1 685 19
	ldr	r3, [sp]
	ldrb	r3, [r3, #62]	@ zero_extendqisi2
	.loc 1 685 5
	cmp	r3, #0
	beq	.L67
	.loc 1 687 13
	ldr	r3, [sp, #4]
	ldrh	r2, [r3]
	.loc 1 687 29
	ldr	r3, [sp]
	ldrh	r3, [r3, #66]
	.loc 1 687 13
	add	r3, r3, r2
	uxth	r2, r3
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
.L67:
	.loc 1 689 1
	nop
	add	sp, sp, #24
.LCFI27:
	@ sp needed
	bx	lr
.L69:
	.align	2
.L68:
	.word	.LC2
	.word	274877907
.LFE9:
	.size	bme680_get_profile_dur, .-bme680_get_profile_dur
	.section	.text.bme680_get_sensor_data,"ax",%progbits
	.align	1
	.global	bme680_get_sensor_data
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	bme680_get_sensor_data, %function
bme680_get_sensor_data:
.LFB10:
	.loc 1 697 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI28:
	sub	sp, sp, #20
.LCFI29:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 701 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 702 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L71
	.loc 1 704 10
	ldr	r1, [sp]
	ldr	r0, [sp, #4]
	bl	read_field_data
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 705 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L71
	.loc 1 706 12
	ldr	r3, [sp, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 706 8
	sxtb	r3, r3
	.loc 1 706 7
	cmp	r3, #0
	bge	.L72
	.loc 1 707 21
	ldr	r3, [sp]
	movs	r2, #1
	strb	r2, [r3, #69]
	b	.L71
.L72:
	.loc 1 709 21
	ldr	r3, [sp]
	movs	r2, #0
	strb	r2, [r3, #69]
.L71:
	.loc 1 713 9
	ldrsb	r3, [sp, #15]
	.loc 1 714 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI30:
	@ sp needed
	ldr	pc, [sp], #4
.LFE10:
	.size	bme680_get_sensor_data, .-bme680_get_sensor_data
	.section	.text.get_calib_data,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	get_calib_data, %function
get_calib_data:
.LFB11:
	.loc 1 720 1
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI31:
	sub	sp, sp, #60
.LCFI32:
	str	r0, [sp, #4]
	.loc 1 722 10
	movs	r3, #0
	str	r3, [sp, #12]
	add	r3, sp, #16
	movs	r2, #37
	movs	r1, #0
	mov	r0, r3
	bl	memset
	.loc 1 723 10
	movs	r3, #0
	strb	r3, [sp, #11]
	.loc 1 726 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #55]
	.loc 1 727 5
	ldrsb	r3, [sp, #55]
	cmp	r3, #0
	bne	.L75
	.loc 1 728 10
	add	r1, sp, #12
	ldr	r3, [sp, #4]
	movs	r2, #25
	movs	r0, #137
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #55]
	.loc 1 730 6
	ldrsb	r3, [sp, #55]
	cmp	r3, #0
	bne	.L76
	.loc 1 731 11
	add	r3, sp, #12
	add	r1, r3, #25
	ldr	r3, [sp, #4]
	movs	r2, #16
	movs	r0, #225
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #55]
.L76:
	.loc 1 735 35
	ldrb	r3, [sp, #46]	@ zero_extendqisi2
	lsls	r3, r3, #8
	sxth	r2, r3
	ldrb	r3, [sp, #45]	@ zero_extendqisi2
	sxth	r3, r3
	orrs	r3, r3, r2
	sxth	r3, r3
	.loc 1 735 23
	uxth	r2, r3
	.loc 1 735 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #22]	@ movhi
	.loc 1 737 34
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 737 23
	sxth	r2, r3
	.loc 1 737 34
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 737 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 737 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #24]	@ movhi
	.loc 1 739 44
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	.loc 1 739 23
	sxtb	r2, r3
	.loc 1 739 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #26]
	.loc 1 742 35
	ldrb	r3, [sp, #18]	@ zero_extendqisi2
	lsls	r3, r3, #8
	sxth	r2, r3
	ldrb	r3, [sp, #17]	@ zero_extendqisi2
	sxth	r3, r3
	orrs	r3, r3, r2
	sxth	r3, r3
	.loc 1 742 23
	uxth	r2, r3
	.loc 1 742 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #28]	@ movhi
	.loc 1 744 34
	ldrb	r3, [sp, #20]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 744 23
	sxth	r2, r3
	.loc 1 744 34
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 744 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 744 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #30]	@ movhi
	.loc 1 746 43
	ldrb	r3, [sp, #21]	@ zero_extendqisi2
	.loc 1 746 23
	sxtb	r2, r3
	.loc 1 746 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #32]
	.loc 1 747 34
	ldrb	r3, [sp, #24]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 747 23
	sxth	r2, r3
	.loc 1 747 34
	ldrb	r3, [sp, #23]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 747 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 747 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #34]	@ movhi
	.loc 1 749 34
	ldrb	r3, [sp, #26]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 749 23
	sxth	r2, r3
	.loc 1 749 34
	ldrb	r3, [sp, #25]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 749 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 749 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #36]	@ movhi
	.loc 1 751 44
	ldrb	r3, [sp, #28]	@ zero_extendqisi2
	.loc 1 751 23
	sxtb	r2, r3
	.loc 1 751 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #38]
	.loc 1 752 44
	ldrb	r3, [sp, #27]	@ zero_extendqisi2
	.loc 1 752 23
	sxtb	r2, r3
	.loc 1 752 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #39]
	.loc 1 753 34
	ldrb	r3, [sp, #32]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 753 23
	sxth	r2, r3
	.loc 1 753 34
	ldrb	r3, [sp, #31]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 753 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 753 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #40]	@ movhi
	.loc 1 755 34
	ldrb	r3, [sp, #34]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 755 23
	sxth	r2, r3
	.loc 1 755 34
	ldrb	r3, [sp, #33]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 755 23
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 755 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #42]	@ movhi
	.loc 1 757 46
	ldrb	r2, [sp, #35]	@ zero_extendqisi2
	.loc 1 757 22
	ldr	r3, [sp, #4]
	strb	r2, [r3, #44]
	.loc 1 760 58
	ldrb	r3, [sp, #39]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 760 78
	lsls	r3, r3, #4
	uxth	r2, r3
	.loc 1 761 18
	ldrb	r3, [sp, #38]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 761 38
	and	r3, r3, #15
	uxth	r3, r3
	.loc 1 760 23
	orrs	r3, r3, r2
	uxth	r2, r3
	.loc 1 760 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #8]	@ movhi
	.loc 1 762 58
	ldrb	r3, [sp, #37]	@ zero_extendqisi2
	.loc 1 762 78
	lsls	r3, r3, #4
	.loc 1 763 4
	sxth	r2, r3
	.loc 1 763 19
	ldrb	r3, [sp, #38]	@ zero_extendqisi2
	.loc 1 763 4
	lsrs	r3, r3, #4
	uxtb	r3, r3
	sxth	r3, r3
	orrs	r3, r3, r2
	sxth	r3, r3
	.loc 1 762 23
	uxth	r2, r3
	.loc 1 762 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #10]	@ movhi
	.loc 1 764 43
	ldrb	r3, [sp, #40]	@ zero_extendqisi2
	.loc 1 764 23
	sxtb	r2, r3
	.loc 1 764 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #12]
	.loc 1 765 43
	ldrb	r3, [sp, #41]	@ zero_extendqisi2
	.loc 1 765 23
	sxtb	r2, r3
	.loc 1 765 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #13]
	.loc 1 766 43
	ldrb	r3, [sp, #42]	@ zero_extendqisi2
	.loc 1 766 23
	sxtb	r2, r3
	.loc 1 766 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #14]
	.loc 1 767 44
	ldrb	r2, [sp, #43]	@ zero_extendqisi2
	.loc 1 767 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #15]
	.loc 1 768 43
	ldrb	r3, [sp, #44]	@ zero_extendqisi2
	.loc 1 768 23
	sxtb	r2, r3
	.loc 1 768 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #16]
	.loc 1 771 44
	ldrb	r3, [sp, #49]	@ zero_extendqisi2
	.loc 1 771 24
	sxtb	r2, r3
	.loc 1 771 22
	ldr	r3, [sp, #4]
	strb	r2, [r3, #17]
	.loc 1 772 35
	ldrb	r3, [sp, #48]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 772 24
	sxth	r2, r3
	.loc 1 772 35
	ldrb	r3, [sp, #47]	@ zero_extendqisi2
	sxth	r3, r3
	.loc 1 772 24
	orrs	r3, r3, r2
	sxth	r2, r3
	.loc 1 772 22
	ldr	r3, [sp, #4]
	strh	r2, [r3, #18]	@ movhi
	.loc 1 774 44
	ldrb	r3, [sp, #50]	@ zero_extendqisi2
	.loc 1 774 24
	sxtb	r2, r3
	.loc 1 774 22
	ldr	r3, [sp, #4]
	strb	r2, [r3, #20]
	.loc 1 777 6
	ldrsb	r3, [sp, #55]
	cmp	r3, #0
	bne	.L77
	.loc 1 778 11
	add	r1, sp, #11
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #2
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #55]
	.loc 1 780 43
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	and	r3, r3, #48
	.loc 1 780 65
	lsrs	r3, r3, #4
	.loc 1 780 30
	uxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3, #52]
	.loc 1 781 7
	ldrsb	r3, [sp, #55]
	cmp	r3, #0
	bne	.L77
	.loc 1 782 12
	add	r1, sp, #11
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #0
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #55]
	.loc 1 784 31
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	sxtb	r2, r3
	.loc 1 784 29
	ldr	r3, [sp, #4]
	strb	r2, [r3, #53]
	.loc 1 785 8
	ldrsb	r3, [sp, #55]
	cmp	r3, #0
	bne	.L77
	.loc 1 786 13
	add	r1, sp, #11
	ldr	r3, [sp, #4]
	movs	r2, #1
	movs	r0, #4
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #55]
.L77:
	.loc 1 789 30
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	sxtb	r3, r3
	.loc 1 789 27
	asrs	r3, r3, #4
	sxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3, #54]
.L75:
	.loc 1 792 9
	ldrsb	r3, [sp, #55]
	.loc 1 793 1
	mov	r0, r3
	add	sp, sp, #60
.LCFI33:
	@ sp needed
	ldr	pc, [sp], #4
.LFE11:
	.size	get_calib_data, .-get_calib_data
	.section	.text.set_gas_config,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	set_gas_config, %function
set_gas_config:
.LFB12:
	.loc 1 799 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI34:
	sub	sp, sp, #20
.LCFI35:
	str	r0, [sp, #4]
	.loc 1 803 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 804 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L80
.LBB2:
	.loc 1 806 11
	movs	r3, #0
	strh	r3, [sp, #12]	@ movhi
	.loc 1 807 11
	movs	r3, #0
	strh	r3, [sp, #8]	@ movhi
	.loc 1 809 10
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #68]	@ zero_extendqisi2
	.loc 1 809 6
	cmp	r3, #1
	bne	.L81
	.loc 1 810 16
	movs	r3, #90
	strb	r3, [sp, #12]
	.loc 1 811 18
	ldr	r3, [sp, #4]
	ldrh	r3, [r3, #64]
	ldr	r1, [sp, #4]
	mov	r0, r3
	bl	calc_heater_res
	mov	r3, r0
	.loc 1 811 16
	strb	r3, [sp, #8]
	.loc 1 812 16
	movs	r3, #100
	strb	r3, [sp, #13]
	.loc 1 813 18
	ldr	r3, [sp, #4]
	ldrh	r3, [r3, #66]
	mov	r0, r3
	bl	calc_heater_dur
	mov	r3, r0
	.loc 1 813 16
	strb	r3, [sp, #9]
	.loc 1 814 26
	ldr	r3, [sp, #4]
	movs	r2, #0
	strb	r2, [r3, #60]
	b	.L82
.L81:
	.loc 1 816 9
	movs	r3, #1
	strb	r3, [sp, #15]
.L82:
	.loc 1 818 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L80
	.loc 1 819 11
	add	r1, sp, #8
	add	r0, sp, #12
	ldr	r3, [sp, #4]
	movs	r2, #2
	bl	bme680_set_regs
	mov	r3, r0
	strb	r3, [sp, #15]
.L80:
.LBE2:
	.loc 1 822 9
	ldrsb	r3, [sp, #15]
	.loc 1 823 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI36:
	@ sp needed
	ldr	pc, [sp], #4
.LFE12:
	.size	set_gas_config, .-set_gas_config
	.section	.text.get_gas_config,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	get_gas_config, %function
get_gas_config:
.LFB13:
	.loc 1 831 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI37:
	sub	sp, sp, #20
.LCFI38:
	str	r0, [sp, #4]
	.loc 1 834 10
	movs	r3, #90
	strb	r3, [sp, #14]
	.loc 1 835 10
	movs	r3, #100
	strb	r3, [sp, #13]
	.loc 1 836 10
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 839 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 840 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L86
	.loc 1 841 29
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 841 6
	cmp	r3, #0
	bne	.L87
	.loc 1 843 11
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	ldr	r1, [sp, #4]
	mov	r0, r3
	bl	set_mem_page
	mov	r3, r0
	strb	r3, [sp, #15]
.L87:
	.loc 1 846 6
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L86
	.loc 1 847 11
	add	r1, sp, #12
	ldrb	r0, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp, #4]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 848 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L86
	.loc 1 849 30
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	uxth	r2, r3
	ldr	r3, [sp, #4]
	strh	r2, [r3, #64]	@ movhi
	.loc 1 850 12
	add	r1, sp, #12
	ldrb	r0, [sp, #13]	@ zero_extendqisi2
	ldr	r3, [sp, #4]
	movs	r2, #1
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 851 8
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L86
	.loc 1 853 30
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	uxth	r2, r3
	ldr	r3, [sp, #4]
	strh	r2, [r3, #66]	@ movhi
.L86:
	.loc 1 859 9
	ldrsb	r3, [sp, #15]
	.loc 1 860 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI39:
	@ sp needed
	ldr	pc, [sp], #4
.LFE13:
	.size	get_gas_config, .-get_gas_config
	.section	.text.calc_temperature,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_temperature, %function
calc_temperature:
.LFB14:
	.loc 1 868 1
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5}
.LCFI40:
	sub	sp, sp, #40
.LCFI41:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 874 10
	ldr	r3, [sp, #4]
	.loc 1 874 29
	asrs	r2, r3, #3
	.loc 1 874 58
	ldr	r3, [sp]
	ldrh	r3, [r3, #22]
	.loc 1 874 66
	lsls	r3, r3, #1
	.loc 1 874 35
	subs	r3, r2, r3
	.loc 1 874 7
	mov	r2, r3
	asr	r3, r2, #31
	strd	r2, [sp, #32]
	.loc 1 875 37
	ldr	r3, [sp]
	ldrsh	r3, [r3, #24]
	.loc 1 875 17
	sxth	r2, r3
	asr	r3, r2, #31
	.loc 1 875 15
	ldr	r1, [sp, #32]
	mul	r0, r3, r1
	ldr	r1, [sp, #36]
	mul	r1, r2, r1
	adds	r4, r0, r1
	ldr	r1, [sp, #32]
	umull	r0, r1, r1, r2
	adds	r3, r4, r1
	mov	r1, r3
	.loc 1 875 7
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #11
	orr	r2, r2, r1, lsl #21
	asrs	r3, r1, #11
	strd	r2, [sp, #24]
	.loc 1 876 16
	ldrd	r2, [sp, #32]
	mov	r0, #0
	mov	r1, #0
	lsrs	r0, r2, #1
	orr	r0, r0, r3, lsl #31
	asrs	r1, r3, #1
	.loc 1 876 30
	ldrd	r4, [sp, #32]
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r4, #1
	orr	r2, r2, r5, lsl #31
	asrs	r3, r5, #1
	.loc 1 876 22
	mul	r5, r2, r1
	mul	r4, r0, r3
	add	r4, r4, r5
	umull	r0, r1, r0, r2
	adds	r3, r4, r1
	mov	r1, r3
	.loc 1 876 7
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #12
	orr	r2, r2, r1, lsl #20
	asrs	r3, r1, #12
	strd	r2, [sp, #16]
	.loc 1 877 40
	ldr	r3, [sp]
	ldrsb	r3, [r3, #26]
	.loc 1 877 48
	lsls	r3, r3, #4
	mov	r2, r3
	asr	r3, r2, #31
	.loc 1 877 17
	ldr	r1, [sp, #16]
	mul	r0, r3, r1
	ldr	r1, [sp, #20]
	mul	r1, r2, r1
	adds	r4, r0, r1
	ldr	r1, [sp, #16]
	umull	r0, r1, r1, r2
	adds	r3, r4, r1
	mov	r1, r3
	.loc 1 877 7
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #14
	orr	r2, r2, r1, lsl #18
	asrs	r3, r1, #14
	strd	r2, [sp, #16]
	.loc 1 878 38
	ldr	r2, [sp, #24]
	ldr	r3, [sp, #16]
	add	r3, r3, r2
	.loc 1 878 22
	mov	r2, r3
	.loc 1 878 20
	ldr	r3, [sp]
	str	r2, [r3, #48]
	.loc 1 879 37
	ldr	r3, [sp]
	ldr	r2, [r3, #48]
	.loc 1 879 45
	mov	r3, r2
	lsls	r3, r3, #2
	add	r3, r3, r2
	.loc 1 879 50
	adds	r3, r3, #128
	.loc 1 879 57
	asrs	r3, r3, #8
	.loc 1 879 12
	strh	r3, [sp, #14]	@ movhi
	.loc 1 881 9
	ldrsh	r3, [sp, #14]
	.loc 1 882 1
	mov	r0, r3
	add	sp, sp, #40
.LCFI42:
	@ sp needed
	pop	{r4, r5}
.LCFI43:
	bx	lr
.LFE14:
	.size	calc_temperature, .-calc_temperature
	.section	.text.calc_pressure,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_pressure, %function
calc_pressure:
.LFB15:
	.loc 1 888 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #24
.LCFI44:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 894 30
	ldr	r3, [sp]
	ldr	r3, [r3, #48]
	.loc 1 894 39
	asrs	r3, r3, #1
	.loc 1 894 7
	sub	r3, r3, #64000
	str	r3, [sp, #16]
	.loc 1 895 18
	ldr	r3, [sp, #16]
	asrs	r3, r3, #2
	.loc 1 895 32
	ldr	r2, [sp, #16]
	asrs	r2, r2, #2
	.loc 1 895 24
	mul	r3, r2, r3
	.loc 1 895 39
	asrs	r3, r3, #11
	.loc 1 896 22
	ldr	r2, [sp]
	ldrsb	r2, [r2, #38]
	.loc 1 895 46
	mul	r3, r2, r3
	.loc 1 895 7
	asrs	r3, r3, #2
	str	r3, [sp, #12]
	.loc 1 897 44
	ldr	r3, [sp]
	ldrsh	r3, [r3, #36]
	.loc 1 897 25
	mov	r2, r3
	.loc 1 897 23
	ldr	r3, [sp, #16]
	mul	r3, r3, r2
	.loc 1 897 53
	lsls	r3, r3, #1
	.loc 1 897 7
	ldr	r2, [sp, #12]
	add	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 898 15
	ldr	r3, [sp, #12]
	asrs	r2, r3, #2
	.loc 1 898 43
	ldr	r3, [sp]
	ldrsh	r3, [r3, #34]
	.loc 1 898 51
	lsls	r3, r3, #16
	.loc 1 898 7
	add	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 899 19
	ldr	r3, [sp, #16]
	asrs	r3, r3, #2
	.loc 1 899 33
	ldr	r2, [sp, #16]
	asrs	r2, r2, #2
	.loc 1 899 25
	mul	r3, r2, r3
	.loc 1 899 40
	asrs	r3, r3, #13
	.loc 1 900 23
	ldr	r2, [sp]
	ldrsb	r2, [r2, #32]
	.loc 1 900 31
	lsls	r2, r2, #5
	.loc 1 899 47
	mul	r3, r2, r3
	.loc 1 900 38
	asrs	r2, r3, #3
	.loc 1 901 24
	ldr	r3, [sp]
	ldrsh	r3, [r3, #30]
	.loc 1 901 5
	mov	r1, r3
	.loc 1 901 32
	ldr	r3, [sp, #16]
	mul	r3, r3, r1
	.loc 1 901 40
	asrs	r3, r3, #1
	.loc 1 899 7
	add	r3, r3, r2
	str	r3, [sp, #16]
	.loc 1 902 7
	ldr	r3, [sp, #16]
	asrs	r3, r3, #18
	str	r3, [sp, #16]
	.loc 1 903 17
	ldr	r3, [sp, #16]
	add	r3, r3, #32768
	.loc 1 903 46
	ldr	r2, [sp]
	ldrh	r2, [r2, #28]
	.loc 1 903 25
	mul	r3, r2, r3
	.loc 1 903 7
	asrs	r3, r3, #15
	str	r3, [sp, #16]
	.loc 1 904 26
	ldr	r3, [sp, #4]
	rsb	r3, r3, #1048576
	.loc 1 904 16
	str	r3, [sp, #20]
	.loc 1 905 51
	ldr	r3, [sp, #12]
	asrs	r3, r3, #12
	.loc 1 905 43
	ldr	r2, [sp, #20]
	subs	r3, r2, r3
	mov	r2, r3
	.loc 1 905 59
	movw	r3, #3125
	mul	r3, r3, r2
	.loc 1 905 16
	str	r3, [sp, #20]
	.loc 1 906 5
	ldr	r3, [sp, #20]
	cmp	r3, #1073741824
	blt	.L92
	.loc 1 907 35
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #16]
	sdiv	r3, r2, r3
	.loc 1 907 17
	lsls	r3, r3, #1
	str	r3, [sp, #20]
	b	.L93
.L92:
	.loc 1 909 35
	ldr	r3, [sp, #20]
	lsls	r2, r3, #1
	.loc 1 909 17
	ldr	r3, [sp, #16]
	sdiv	r3, r2, r3
	str	r3, [sp, #20]
.L93:
	.loc 1 910 29
	ldr	r3, [sp]
	ldrsh	r3, [r3, #42]
	.loc 1 910 10
	mov	r1, r3
	.loc 1 910 65
	ldr	r3, [sp, #20]
	asrs	r3, r3, #3
	.loc 1 911 18
	ldr	r2, [sp, #20]
	asrs	r2, r2, #3
	.loc 1 910 71
	mul	r3, r2, r3
	.loc 1 911 25
	asrs	r3, r3, #13
	.loc 1 910 37
	mul	r3, r3, r1
	.loc 1 910 7
	asrs	r3, r3, #12
	str	r3, [sp, #16]
	.loc 1 912 34
	ldr	r3, [sp, #20]
	asrs	r3, r3, #2
	.loc 1 913 22
	ldr	r2, [sp]
	ldrsh	r2, [r2, #40]
	.loc 1 912 40
	mul	r3, r2, r3
	.loc 1 912 7
	asrs	r3, r3, #13
	str	r3, [sp, #12]
	.loc 1 914 34
	ldr	r3, [sp, #20]
	asrs	r3, r3, #8
	.loc 1 914 66
	ldr	r2, [sp, #20]
	asrs	r2, r2, #8
	.loc 1 914 40
	mul	r3, r2, r3
	.loc 1 915 27
	ldr	r2, [sp, #20]
	asrs	r2, r2, #8
	.loc 1 914 72
	mul	r3, r2, r3
	.loc 1 916 22
	ldr	r2, [sp]
	ldrb	r2, [r2, #44]	@ zero_extendqisi2
	.loc 1 915 33
	mul	r3, r2, r3
	.loc 1 914 7
	asrs	r3, r3, #17
	str	r3, [sp, #8]
	.loc 1 918 52
	ldr	r2, [sp, #16]
	ldr	r3, [sp, #12]
	add	r2, r2, r3
	.loc 1 918 59
	ldr	r3, [sp, #8]
	add	r2, r2, r3
	.loc 1 919 23
	ldr	r3, [sp]
	ldrsb	r3, [r3, #39]
	.loc 1 919 31
	lsls	r3, r3, #7
	.loc 1 918 66
	add	r3, r3, r2
	.loc 1 919 38
	asrs	r3, r3, #4
	.loc 1 918 16
	ldr	r2, [sp, #20]
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 921 9
	ldr	r3, [sp, #20]
	.loc 1 923 1
	mov	r0, r3
	add	sp, sp, #24
.LCFI45:
	@ sp needed
	bx	lr
.LFE15:
	.size	calc_pressure, .-calc_pressure
	.section	.text.calc_humidity,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_humidity, %function
calc_humidity:
.LFB16:
	.loc 1 929 1
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #40
.LCFI46:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	.loc 1 939 38
	ldr	r3, [sp]
	ldr	r2, [r3, #48]
	.loc 1 939 46
	mov	r3, r2
	lsls	r3, r3, #2
	add	r3, r3, r2
	.loc 1 939 51
	adds	r3, r3, #128
	.loc 1 939 14
	asrs	r3, r3, #8
	str	r3, [sp, #32]
	.loc 1 940 9
	ldrh	r2, [sp, #6]
	.loc 1 940 62
	ldr	r3, [sp]
	ldrh	r3, [r3, #8]
	.loc 1 940 31
	lsls	r3, r3, #4
	.loc 1 940 9
	subs	r2, r2, r3
	.loc 1 941 42
	ldr	r3, [sp]
	ldrsb	r3, [r3, #12]
	.loc 1 941 22
	mov	r1, r3
	.loc 1 941 20
	ldr	r3, [sp, #32]
	mul	r3, r3, r1
	.loc 1 941 51
	ldr	r1, .L99
	smull	r0, r1, r1, r3
	asrs	r1, r1, #5
	asrs	r3, r3, #31
	subs	r3, r1, r3
	.loc 1 941 70
	asrs	r3, r3, #1
	.loc 1 940 7
	subs	r3, r2, r3
	str	r3, [sp, #28]
	.loc 1 942 30
	ldr	r3, [sp]
	ldrh	r3, [r3, #10]
	.loc 1 942 10
	mov	r0, r3
	.loc 1 943 42
	ldr	r3, [sp]
	ldrsb	r3, [r3, #13]
	.loc 1 943 22
	mov	r2, r3
	.loc 1 943 20
	ldr	r3, [sp, #32]
	mul	r3, r3, r2
	.loc 1 943 51
	ldr	r2, .L99
	smull	r1, r2, r2, r3
	asrs	r2, r2, #5
	asrs	r3, r3, #31
	subs	r2, r2, r3
	.loc 1 944 59
	ldr	r3, [sp]
	ldrsb	r3, [r3, #14]
	.loc 1 944 39
	mov	r1, r3
	.loc 1 944 37
	ldr	r3, [sp, #32]
	mul	r3, r3, r1
	.loc 1 944 68
	ldr	r1, .L99
	smull	ip, r1, r1, r3
	asrs	r1, r1, #5
	asrs	r3, r3, #31
	subs	r3, r1, r3
	.loc 1 944 21
	ldr	r1, [sp, #32]
	mul	r3, r1, r3
	.loc 1 944 88
	asrs	r3, r3, #6
	.loc 1 945 5
	ldr	r1, .L99
	smull	ip, r1, r1, r3
	asrs	r1, r1, #5
	asrs	r3, r3, #31
	subs	r3, r1, r3
	.loc 1 944 4
	add	r3, r3, r2
	.loc 1 945 24
	add	r3, r3, #16384
	.loc 1 943 3
	mul	r3, r3, r0
	.loc 1 942 7
	asrs	r3, r3, #10
	str	r3, [sp, #24]
	.loc 1 946 7
	ldr	r3, [sp, #28]
	ldr	r2, [sp, #24]
	mul	r3, r2, r3
	str	r3, [sp, #20]
	.loc 1 947 29
	ldr	r3, [sp]
	ldrb	r3, [r3, #15]	@ zero_extendqisi2
	.loc 1 947 7
	lsls	r3, r3, #7
	str	r3, [sp, #16]
	.loc 1 948 55
	ldr	r3, [sp]
	ldrsb	r3, [r3, #16]
	.loc 1 948 35
	mov	r2, r3
	.loc 1 948 33
	ldr	r3, [sp, #32]
	mul	r3, r3, r2
	.loc 1 948 64
	ldr	r2, .L99
	smull	r1, r2, r2, r3
	asrs	r2, r2, #5
	asrs	r3, r3, #31
	subs	r2, r2, r3
	.loc 1 948 17
	ldr	r3, [sp, #16]
	add	r3, r3, r2
	.loc 1 948 7
	asrs	r3, r3, #4
	str	r3, [sp, #16]
	.loc 1 949 16
	ldr	r3, [sp, #20]
	asrs	r3, r3, #14
	.loc 1 949 31
	ldr	r2, [sp, #20]
	asrs	r2, r2, #14
	.loc 1 949 23
	mul	r3, r2, r3
	.loc 1 949 7
	asrs	r3, r3, #10
	str	r3, [sp, #12]
	.loc 1 950 15
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #12]
	mul	r3, r2, r3
	.loc 1 950 7
	asrs	r3, r3, #1
	str	r3, [sp, #8]
	.loc 1 951 21
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #8]
	add	r3, r3, r2
	.loc 1 951 29
	asrs	r3, r3, #10
	.loc 1 951 36
	mov	r2, #1000
	mul	r3, r2, r3
	.loc 1 951 11
	asrs	r3, r3, #12
	str	r3, [sp, #36]
	.loc 1 953 5
	ldr	r3, [sp, #36]
	ldr	r2, .L99+4
	cmp	r3, r2
	ble	.L96
	.loc 1 954 12
	ldr	r3, .L99+4
	str	r3, [sp, #36]
	b	.L97
.L96:
	.loc 1 955 10
	ldr	r3, [sp, #36]
	cmp	r3, #0
	bge	.L97
	.loc 1 956 12
	movs	r3, #0
	str	r3, [sp, #36]
.L97:
	.loc 1 958 9
	ldr	r3, [sp, #36]
	.loc 1 959 1
	mov	r0, r3
	add	sp, sp, #40
.LCFI47:
	@ sp needed
	bx	lr
.L100:
	.align	2
.L99:
	.word	1374389535
	.word	100000
.LFE16:
	.size	calc_humidity, .-calc_humidity
	.global	__aeabi_ldivmod
	.section .rodata
	.align	2
.LC0:
	.word	2147483647
	.word	2147483647
	.word	2147483647
	.word	2147483647
	.word	2147483647
	.word	2126008810
	.word	2147483647
	.word	2130303777
	.word	2147483647
	.word	2147483647
	.word	2143188679
	.word	2136746228
	.word	2147483647
	.word	2126008810
	.word	2147483647
	.word	2147483647
	.align	2
.LC1:
	.word	-198967296
	.word	2048000000
	.word	1024000000
	.word	512000000
	.word	255744255
	.word	127110228
	.word	64000000
	.word	32258064
	.word	16016016
	.word	8000000
	.word	4000000
	.word	2000000
	.word	1000000
	.word	500000
	.word	250000
	.word	125000
	.section	.text.calc_gas_resistance,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_gas_resistance, %function
calc_gas_resistance:
.LFB17:
	.loc 1 965 1
	@ args = 0, pretend = 0, frame = 184
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
.LCFI48:
	sub	sp, sp, #188
.LCFI49:
	mov	r3, r0
	str	r2, [sp, #16]
	strh	r3, [sp, #22]	@ movhi
	mov	r3, r1
	strb	r3, [sp, #21]
	.loc 1 971 11
	ldr	r3, .L103
	add	r5, sp, #92
	mov	r4, r3
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldm	r4, {r0, r1, r2, r3}
	stm	r5, {r0, r1, r2, r3}
	.loc 1 976 11
	ldr	r3, .L103+4
	add	r5, sp, #28
	mov	r4, r3
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	r5!, {r0, r1, r2, r3}
	ldm	r4, {r0, r1, r2, r3}
	stm	r5, {r0, r1, r2, r3}
	.loc 1 981 53
	ldr	r3, [sp, #16]
	ldrsb	r3, [r3, #54]
	.loc 1 981 33
	sxtb	r4, r3
	asr	r5, r4, #31
	.loc 1 981 31
	mov	r2, r4
	mov	r3, r5
	mov	r0, #0
	mov	r1, #0
	lsls	r1, r3, #2
	orr	r1, r1, r2, lsr #30
	lsls	r0, r2, #2
	mov	r2, r0
	mov	r3, r1
	adds	r10, r2, r4
	adc	fp, r3, r5
	.loc 1 981 26
	movw	r2, #1340
	mov	r3, #0
	adds	r6, r10, r2
	adc	r7, fp, r3
	.loc 1 982 26
	ldrb	r3, [sp, #21]	@ zero_extendqisi2
	lsls	r3, r3, #2
	add	r2, sp, #184
	add	r3, r3, r2
	ldr	r3, [r3, #-92]
	.loc 1 982 4
	mov	r2, r3
	mov	r3, #0
	.loc 1 981 9
	mul	r0, r2, r7
	mul	r1, r6, r3
	adds	r4, r0, r1
	umull	r0, r1, r6, r2
	adds	r3, r4, r1
	mov	r1, r3
	.loc 1 981 7
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #16
	orr	r2, r2, r1, lsl #16
	asrs	r3, r1, #16
	strd	r2, [sp, #176]
	.loc 1 983 22
	ldrh	r0, [sp, #22]
	mov	r1, #0
	.loc 1 983 11
	mov	r2, #0
	mov	r3, #0
	lsls	r3, r1, #15
	orr	r3, r3, r0, lsr #17
	lsls	r2, r0, #15
	.loc 1 983 51
	adds	r8, r2, #-16777216
	adc	r9, r3, #-1
	.loc 1 983 75
	ldrd	r2, [sp, #176]
	adds	r1, r8, r2
	str	r1, [sp]
	adc	r3, r9, r3
	str	r3, [sp, #4]
	.loc 1 983 7
	ldrd	r3, [sp]
	strd	r3, [sp, #168]
	.loc 1 984 33
	ldrb	r3, [sp, #21]	@ zero_extendqisi2
	lsls	r3, r3, #2
	add	r2, sp, #184
	add	r3, r3, r2
	ldr	r3, [r3, #-156]
	.loc 1 984 11
	mov	r2, r3
	mov	r3, #0
	.loc 1 984 45
	ldr	r1, [sp, #176]
	mul	r0, r3, r1
	ldr	r1, [sp, #180]
	mul	r1, r2, r1
	adds	r4, r0, r1
	ldr	r1, [sp, #176]
	umull	r0, r1, r1, r2
	adds	r3, r4, r1
	mov	r1, r3
	.loc 1 984 7
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #9
	orr	r2, r2, r1, lsl #23
	asrs	r3, r1, #9
	strd	r2, [sp, #160]
	.loc 1 985 38
	ldrd	r0, [sp, #168]
	.loc 1 985 53
	mov	r2, #0
	mov	r3, #0
	lsrs	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	asrs	r3, r1, #1
	.loc 1 985 35
	ldrd	r0, [sp, #160]
	adds	r4, r2, r0
	str	r4, [sp, #8]
	adcs	r3, r3, r1
	str	r3, [sp, #12]
	.loc 1 985 62
	ldrd	r2, [sp, #168]
	.loc 1 985 60
	ldrd	r0, [sp, #8]
	bl	__aeabi_ldivmod
.LVL4:
	mov	r2, r0
	mov	r3, r1
	.loc 1 985 15
	mov	r3, r2
	str	r3, [sp, #156]
	.loc 1 987 9
	ldr	r3, [sp, #156]
	.loc 1 988 1
	mov	r0, r3
	add	sp, sp, #188
.LCFI50:
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L104:
	.align	2
.L103:
	.word	.LC0
	.word	.LC1
.LFE17:
	.size	calc_gas_resistance, .-calc_gas_resistance
	.section	.text.calc_heater_res,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_heater_res, %function
calc_heater_res:
.LFB18:
	.loc 1 994 1
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #40
.LCFI51:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1003 5
	ldrh	r3, [sp, #6]
	cmp	r3, #400
	bls	.L106
	.loc 1 1004 8
	mov	r3, #400
	strh	r3, [sp, #6]	@ movhi
.L106:
	.loc 1 1006 24
	ldr	r3, [sp]
	ldrsb	r3, [r3, #4]
	.loc 1 1006 11
	mov	r2, r3
	.loc 1 1006 47
	ldr	r3, [sp]
	ldrsb	r3, [r3, #20]
	.loc 1 1006 35
	mul	r3, r3, r2
	.loc 1 1006 57
	ldr	r2, .L108
	smull	r1, r2, r2, r3
	asrs	r2, r2, #6
	asrs	r3, r3, #31
	subs	r3, r2, r3
	.loc 1 1006 7
	lsls	r3, r3, #8
	str	r3, [sp, #36]
	.loc 1 1007 20
	ldr	r3, [sp]
	ldrsb	r3, [r3, #17]
	.loc 1 1007 29
	add	r2, r3, #784
	.loc 1 1007 53
	ldr	r3, [sp]
	ldrsh	r3, [r3, #18]
	.loc 1 1007 62
	add	r3, r3, #153600
	addw	r3, r3, #409
	.loc 1 1007 72
	ldrh	r1, [sp, #6]
	mul	r3, r1, r3
	.loc 1 1007 84
	ldr	r1, .L108+4
	smull	r0, r1, r1, r3
	asrs	r1, r1, #3
	asrs	r3, r3, #31
	subs	r3, r1, r3
	.loc 1 1007 91
	add	r3, r3, #3276800
	.loc 1 1007 102
	ldr	r1, .L108+4
	smull	r0, r1, r1, r3
	asrs	r1, r1, #2
	asrs	r3, r3, #31
	subs	r3, r1, r3
	.loc 1 1007 7
	mul	r3, r3, r2
	str	r3, [sp, #32]
	.loc 1 1008 22
	ldr	r3, [sp, #32]
	lsrs	r2, r3, #31
	add	r3, r3, r2
	asrs	r3, r3, #1
	mov	r2, r3
	.loc 1 1008 7
	ldr	r3, [sp, #36]
	add	r3, r3, r2
	str	r3, [sp, #28]
	.loc 1 1009 28
	ldr	r3, [sp]
	ldrb	r3, [r3, #52]	@ zero_extendqisi2
	.loc 1 1009 44
	adds	r3, r3, #4
	.loc 1 1009 7
	ldr	r2, [sp, #28]
	sdiv	r3, r2, r3
	str	r3, [sp, #24]
	.loc 1 1010 26
	ldr	r3, [sp]
	ldrsb	r3, [r3, #53]
	mov	r2, r3
	.loc 1 1010 14
	mov	r3, r2
	lsls	r3, r3, #6
	add	r3, r3, r2
	lsls	r3, r3, #1
	add	r3, r3, r2
	.loc 1 1010 7
	add	r3, r3, #65536
	str	r3, [sp, #20]
	.loc 1 1011 37
	ldr	r2, [sp, #24]
	ldr	r3, [sp, #20]
	sdiv	r3, r2, r3
	.loc 1 1011 45
	sub	r2, r3, #250
	.loc 1 1011 17
	mov	r3, r2
	lsls	r3, r3, #4
	add	r3, r3, r2
	lsls	r3, r3, #1
	str	r3, [sp, #16]
	.loc 1 1012 41
	ldr	r3, [sp, #16]
	adds	r3, r3, #50
	.loc 1 1012 47
	ldr	r2, .L108+8
	smull	r1, r2, r2, r3
	asrs	r2, r2, #5
	asrs	r3, r3, #31
	subs	r3, r2, r3
	.loc 1 1012 12
	strb	r3, [sp, #15]
	.loc 1 1014 9
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	.loc 1 1015 1
	mov	r0, r3
	add	sp, sp, #40
.LCFI52:
	@ sp needed
	bx	lr
.L109:
	.align	2
.L108:
	.word	274877907
	.word	1717986919
	.word	1374389535
.LFE18:
	.size	calc_heater_res, .-calc_heater_res
	.section	.text.calc_heater_dur,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	calc_heater_dur, %function
calc_heater_dur:
.LFB19:
	.loc 1 1180 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI53:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1181 10
	movs	r3, #0
	strb	r3, [sp, #15]
	.loc 1 1184 5
	ldrh	r3, [sp, #6]
	cmp	r3, #4032
	bcc	.L113
	.loc 1 1185 10
	movs	r3, #255
	strb	r3, [sp, #14]
	b	.L112
.L114:
	.loc 1 1188 8
	ldrh	r3, [sp, #6]
	lsrs	r3, r3, #2
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1189 11
	ldrb	r3, [sp, #15]
	adds	r3, r3, #1
	strb	r3, [sp, #15]
.L113:
	.loc 1 1187 9
	ldrh	r3, [sp, #6]
	cmp	r3, #63
	bhi	.L114
	.loc 1 1191 12
	ldrh	r3, [sp, #6]	@ movhi
	uxtb	r2, r3
	ldrb	r3, [sp, #15]
	lsls	r3, r3, #6
	uxtb	r3, r3
	.loc 1 1191 10
	add	r3, r3, r2
	strb	r3, [sp, #14]
.L112:
	.loc 1 1194 9
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	.loc 1 1195 1
	mov	r0, r3
	add	sp, sp, #16
.LCFI54:
	@ sp needed
	bx	lr
.LFE19:
	.size	calc_heater_dur, .-calc_heater_dur
	.section	.text.read_field_data,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	read_field_data, %function
read_field_data:
.LFB20:
	.loc 1 1201 1
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI55:
	sub	sp, sp, #44
.LCFI56:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 1203 10
	movs	r3, #0
	str	r3, [sp, #8]
	add	r3, sp, #12
	movs	r2, #0
	str	r2, [r3]
	str	r2, [r3, #4]
	str	r2, [r3, #7]	@ unaligned
	.loc 1 1209 10
	movs	r3, #10
	strb	r3, [sp, #38]
	.loc 1 1212 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #39]
.L120:
	.loc 1 1214 6
	ldrsb	r3, [sp, #39]
	cmp	r3, #0
	bne	.L117
	.loc 1 1215 11
	add	r1, sp, #8
	ldr	r3, [sp]
	movs	r2, #15
	movs	r0, #29
	bl	bme680_get_regs
	mov	r3, r0
	strb	r3, [sp, #39]
	.loc 1 1218 23
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	.loc 1 1218 27
	bic	r3, r3, #127
	uxtb	r2, r3
	.loc 1 1218 17
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 1 1219 26
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	.loc 1 1219 30
	and	r3, r3, #15
	uxtb	r2, r3
	.loc 1 1219 20
	ldr	r3, [sp, #4]
	strb	r2, [r3, #1]
	.loc 1 1220 27
	ldrb	r2, [sp, #9]	@ zero_extendqisi2
	.loc 1 1220 21
	ldr	r3, [sp, #4]
	strb	r2, [r3, #2]
	.loc 1 1223 43
	ldrb	r3, [sp, #10]	@ zero_extendqisi2
	.loc 1 1223 47
	lsls	r2, r3, #12
	.loc 1 1223 73
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	.loc 1 1223 77
	lsls	r3, r3, #4
	.loc 1 1223 55
	orrs	r3, r3, r2
	.loc 1 1224 23
	ldrb	r2, [sp, #12]	@ zero_extendqisi2
	.loc 1 1224 27
	lsrs	r2, r2, #4
	uxtb	r2, r2
	.loc 1 1223 13
	orrs	r3, r3, r2
	str	r3, [sp, #32]
	.loc 1 1225 43
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 1225 47
	lsls	r2, r3, #12
	.loc 1 1225 73
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	.loc 1 1225 77
	lsls	r3, r3, #4
	.loc 1 1225 55
	orrs	r3, r3, r2
	.loc 1 1226 23
	ldrb	r2, [sp, #15]	@ zero_extendqisi2
	.loc 1 1226 27
	lsrs	r2, r2, #4
	uxtb	r2, r2
	.loc 1 1225 13
	orrs	r3, r3, r2
	str	r3, [sp, #28]
	.loc 1 1227 42
	ldrb	r3, [sp, #16]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 1227 46
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 1 1227 70
	ldrb	r3, [sp, #17]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 1227 12
	orrs	r3, r3, r2
	strh	r3, [sp, #26]	@ movhi
	.loc 1 1228 45
	ldrb	r3, [sp, #21]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 1228 50
	lsls	r3, r3, #2
	uxth	r2, r3
	.loc 1 1228 73
	ldrb	r3, [sp, #22]	@ zero_extendqisi2
	.loc 1 1228 18
	lsrs	r3, r3, #6
	uxtb	r3, r3
	uxth	r3, r3
	.loc 1 1228 16
	orrs	r3, r3, r2
	strh	r3, [sp, #24]	@ movhi
	.loc 1 1229 20
	ldrb	r3, [sp, #22]	@ zero_extendqisi2
	.loc 1 1229 14
	and	r3, r3, #15
	strb	r3, [sp, #23]
	.loc 1 1231 17
	ldr	r3, [sp, #4]
	ldrb	r2, [r3]	@ zero_extendqisi2
	.loc 1 1231 24
	ldrb	r3, [sp, #22]	@ zero_extendqisi2
	.loc 1 1231 29
	and	r3, r3, #32
	uxtb	r3, r3
	.loc 1 1231 17
	orrs	r3, r3, r2
	uxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 1 1232 17
	ldr	r3, [sp, #4]
	ldrb	r2, [r3]	@ zero_extendqisi2
	.loc 1 1232 24
	ldrb	r3, [sp, #22]	@ zero_extendqisi2
	.loc 1 1232 29
	and	r3, r3, #16
	uxtb	r3, r3
	.loc 1 1232 17
	orrs	r3, r3, r2
	uxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3]
	.loc 1 1234 12
	ldr	r3, [sp, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 1234 8
	sxtb	r3, r3
	.loc 1 1234 7
	cmp	r3, #0
	bge	.L118
	.loc 1 1235 25
	ldr	r1, [sp]
	ldr	r0, [sp, #28]
	bl	calc_temperature
	mov	r3, r0
	mov	r2, r3
	.loc 1 1235 23
	ldr	r3, [sp, #4]
	strh	r2, [r3, #4]	@ movhi
	.loc 1 1236 22
	ldr	r1, [sp]
	ldr	r0, [sp, #32]
	bl	calc_pressure
	mov	r2, r0
	.loc 1 1236 20
	ldr	r3, [sp, #4]
	str	r2, [r3, #8]
	.loc 1 1237 22
	ldrh	r3, [sp, #26]
	ldr	r1, [sp]
	mov	r0, r3
	bl	calc_humidity
	mov	r2, r0
	.loc 1 1237 20
	ldr	r3, [sp, #4]
	str	r2, [r3, #12]
	.loc 1 1238 28
	ldrb	r1, [sp, #23]	@ zero_extendqisi2
	ldrh	r3, [sp, #24]
	ldr	r2, [sp]
	mov	r0, r3
	bl	calc_gas_resistance
	mov	r2, r0
	.loc 1 1238 26
	ldr	r3, [sp, #4]
	str	r2, [r3, #16]
	.loc 1 1239 5
	b	.L119
.L118:
	.loc 1 1242 7
	ldr	r3, [sp]
	ldr	r3, [r3, #80]
	.loc 1 1242 4
	movs	r0, #10
	blx	r3
.LVL5:
.L117:
	.loc 1 1244 8
	ldrb	r3, [sp, #38]	@ zero_extendqisi2
	subs	r3, r3, #1
	strb	r3, [sp, #38]
	.loc 1 1245 2
	ldrb	r3, [sp, #38]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L120
.L119:
	.loc 1 1247 5
	ldrb	r3, [sp, #38]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L121
	.loc 1 1248 8
	movs	r3, #2
	strb	r3, [sp, #39]
.L121:
	.loc 1 1250 9
	ldrsb	r3, [sp, #39]
	.loc 1 1251 1
	mov	r0, r3
	add	sp, sp, #44
.LCFI57:
	@ sp needed
	ldr	pc, [sp], #4
.LFE20:
	.size	read_field_data, .-read_field_data
	.section	.text.set_mem_page,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	set_mem_page, %function
set_mem_page:
.LFB21:
	.loc 1 1257 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI58:
	sub	sp, sp, #16
.LCFI59:
	mov	r3, r0
	str	r1, [sp]
	strb	r3, [sp, #7]
	.loc 1 1263 9
	ldr	r0, [sp]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 1264 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L124
	.loc 1 1265 16
	ldrsb	r3, [sp, #7]
	.loc 1 1265 6
	cmp	r3, #0
	bge	.L125
	.loc 1 1266 13
	movs	r3, #0
	strb	r3, [sp, #14]
	b	.L126
.L125:
	.loc 1 1268 13
	movs	r3, #16
	strb	r3, [sp, #14]
.L126:
	.loc 1 1270 22
	ldr	r3, [sp]
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	.loc 1 1270 6
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	cmp	r2, r3
	beq	.L124
	.loc 1 1271 18
	ldr	r3, [sp]
	ldrb	r2, [sp, #14]
	strb	r2, [r3, #3]
	.loc 1 1273 23
	ldr	r3, [sp]
	ldr	r4, [r3, #72]
	.loc 1 1273 20
	ldr	r3, [sp]
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	add	r2, sp, #13
	movs	r3, #1
	movs	r1, #243
	blx	r4
.LVL6:
	mov	r3, r0
	mov	r2, r3
	.loc 1 1273 18
	ldr	r3, [sp]
	strb	r2, [r3, #84]
	.loc 1 1274 11
	ldr	r3, [sp]
	ldrsb	r3, [r3, #84]
	.loc 1 1274 7
	cmp	r3, #0
	beq	.L127
	.loc 1 1275 10
	movs	r3, #254
	strb	r3, [sp, #15]
.L127:
	.loc 1 1277 7
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L124
	.loc 1 1278 15
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	bic	r3, r3, #16
	uxtb	r3, r3
	.loc 1 1278 9
	strb	r3, [sp, #13]
	.loc 1 1279 21
	ldr	r3, [sp]
	ldrb	r3, [r3, #3]	@ zero_extendqisi2
	.loc 1 1279 32
	and	r3, r3, #16
	uxtb	r2, r3
	.loc 1 1279 15
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 1279 9
	strb	r3, [sp, #13]
	.loc 1 1281 24
	ldr	r3, [sp]
	ldr	r4, [r3, #76]
	.loc 1 1281 21
	ldr	r3, [sp]
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	add	r2, sp, #13
	movs	r3, #1
	movs	r1, #115
	blx	r4
.LVL7:
	mov	r3, r0
	mov	r2, r3
	.loc 1 1281 19
	ldr	r3, [sp]
	strb	r2, [r3, #84]
	.loc 1 1283 12
	ldr	r3, [sp]
	ldrsb	r3, [r3, #84]
	.loc 1 1283 8
	cmp	r3, #0
	beq	.L124
	.loc 1 1284 11
	movs	r3, #254
	strb	r3, [sp, #15]
.L124:
	.loc 1 1289 9
	ldrsb	r3, [sp, #15]
	.loc 1 1290 1
	mov	r0, r3
	add	sp, sp, #16
.LCFI60:
	@ sp needed
	pop	{r4, pc}
.LFE21:
	.size	set_mem_page, .-set_mem_page
	.section	.text.get_mem_page,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	get_mem_page, %function
get_mem_page:
.LFB22:
	.loc 1 1296 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI61:
	sub	sp, sp, #16
.LCFI62:
	str	r0, [sp, #4]
	.loc 1 1301 9
	ldr	r0, [sp, #4]
	bl	null_ptr_check
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 1302 5
	ldrsb	r3, [sp, #15]
	cmp	r3, #0
	bne	.L130
	.loc 1 1303 22
	ldr	r3, [sp, #4]
	ldr	r4, [r3, #72]
	.loc 1 1303 19
	ldr	r3, [sp, #4]
	ldrb	r0, [r3, #1]	@ zero_extendqisi2
	add	r2, sp, #14
	movs	r3, #1
	movs	r1, #243
	blx	r4
.LVL8:
	mov	r3, r0
	mov	r2, r3
	.loc 1 1303 17
	ldr	r3, [sp, #4]
	strb	r2, [r3, #84]
	.loc 1 1304 10
	ldr	r3, [sp, #4]
	ldrsb	r3, [r3, #84]
	.loc 1 1304 6
	cmp	r3, #0
	beq	.L131
	.loc 1 1305 9
	movs	r3, #254
	strb	r3, [sp, #15]
	b	.L130
.L131:
	.loc 1 1307 24
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	and	r3, r3, #16
	uxtb	r2, r3
	.loc 1 1307 18
	ldr	r3, [sp, #4]
	strb	r2, [r3, #3]
.L130:
	.loc 1 1310 9
	ldrsb	r3, [sp, #15]
	.loc 1 1311 1
	mov	r0, r3
	add	sp, sp, #16
.LCFI63:
	@ sp needed
	pop	{r4, pc}
.LFE22:
	.size	get_mem_page, .-get_mem_page
	.section	.text.boundary_check,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	boundary_check, %function
boundary_check:
.LFB23:
	.loc 1 1318 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #24
.LCFI64:
	str	r0, [sp, #12]
	str	r3, [sp, #4]
	mov	r3, r1
	strb	r3, [sp, #11]
	mov	r3, r2
	strb	r3, [sp, #10]
	.loc 1 1319 9
	movs	r3, #0
	strb	r3, [sp, #23]
	.loc 1 1321 5
	ldr	r3, [sp, #12]
	cmp	r3, #0
	beq	.L134
	.loc 1 1323 7
	ldr	r3, [sp, #12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 1323 6
	ldrb	r2, [sp, #11]	@ zero_extendqisi2
	cmp	r2, r3
	bls	.L135
	.loc 1 1325 11
	ldr	r3, [sp, #12]
	ldrb	r2, [sp, #11]
	strb	r2, [r3]
	.loc 1 1326 18
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #70]	@ zero_extendqisi2
	orr	r3, r3, #1
	uxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3, #70]
.L135:
	.loc 1 1329 7
	ldr	r3, [sp, #12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	.loc 1 1329 6
	ldrb	r2, [sp, #10]	@ zero_extendqisi2
	cmp	r2, r3
	bcs	.L136
	.loc 1 1331 11
	ldr	r3, [sp, #12]
	ldrb	r2, [sp, #10]
	strb	r2, [r3]
	.loc 1 1332 18
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #70]	@ zero_extendqisi2
	orr	r3, r3, #2
	uxtb	r2, r3
	ldr	r3, [sp, #4]
	strb	r2, [r3, #70]
	b	.L136
.L134:
	.loc 1 1335 8
	movs	r3, #255
	strb	r3, [sp, #23]
.L136:
	.loc 1 1338 9
	ldrsb	r3, [sp, #23]
	.loc 1 1339 1
	mov	r0, r3
	add	sp, sp, #24
.LCFI65:
	@ sp needed
	bx	lr
.LFE23:
	.size	boundary_check, .-boundary_check
	.section	.text.null_ptr_check,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	null_ptr_check, %function
null_ptr_check:
.LFB24:
	.loc 1 1346 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI66:
	str	r0, [sp, #4]
	.loc 1 1349 5
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L139
	.loc 1 1349 27 discriminator 1
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #72]
	.loc 1 1349 20 discriminator 1
	cmp	r3, #0
	beq	.L139
	.loc 1 1349 50 discriminator 2
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #76]
	.loc 1 1349 43 discriminator 2
	cmp	r3, #0
	beq	.L139
	.loc 1 1349 74 discriminator 3
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #80]
	.loc 1 1349 67 discriminator 3
	cmp	r3, #0
	bne	.L140
.L139:
	.loc 1 1351 8
	movs	r3, #255
	strb	r3, [sp, #15]
	b	.L141
.L140:
	.loc 1 1354 8
	movs	r3, #0
	strb	r3, [sp, #15]
.L141:
	.loc 1 1357 9
	ldrsb	r3, [sp, #15]
	.loc 1 1358 1
	mov	r0, r3
	add	sp, sp, #16
.LCFI67:
	@ sp needed
	bx	lr
.LFE24:
	.size	null_ptr_check, .-null_ptr_check
	.section	.debug_frame,"",%progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x3
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.uleb128 0xe
	.byte	0xc
	.uleb128 0xd
	.uleb128 0
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI3-.LFB1
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI6-.LFB2
	.byte	0xe
	.uleb128 0xc
	.byte	0x84
	.uleb128 0x3
	.byte	0x85
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0xe
	.uleb128 0x50
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0xe
	.uleb128 0xc
	.align	2
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI9-.LFB3
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI10-.LCFI9
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI11-.LCFI10
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI12-.LFB4
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI13-.LCFI12
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	.LCFI14-.LCFI13
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI15-.LFB5
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI16-.LCFI15
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI17-.LCFI16
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI18-.LFB6
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI19-.LCFI18
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.byte	0x4
	.4byte	.LCFI21-.LFB7
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI22-.LCFI21
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI24-.LFB8
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI25-.LCFI24
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.byte	0x4
	.4byte	.LCFI26-.LFB9
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI27-.LCFI26
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.byte	0x4
	.4byte	.LCFI28-.LFB10
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI29-.LCFI28
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI30-.LCFI29
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.byte	0x4
	.4byte	.LCFI31-.LFB11
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0xe
	.uleb128 0x40
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.byte	0x4
	.4byte	.LCFI34-.LFB12
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI35-.LCFI34
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI36-.LCFI35
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.byte	0x4
	.4byte	.LCFI37-.LFB13
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI38-.LCFI37
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI39-.LCFI38
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.byte	0x4
	.4byte	.LCFI40-.LFB14
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x85
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI41-.LCFI40
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.4byte	.LCFI42-.LCFI41
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.4byte	.LCFI43-.LCFI42
	.byte	0xc5
	.byte	0xc4
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.byte	0x4
	.4byte	.LCFI44-.LFB15
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI45-.LCFI44
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.byte	0x4
	.4byte	.LCFI46-.LFB16
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	.LCFI47-.LCFI46
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.byte	0x4
	.4byte	.LCFI48-.LFB17
	.byte	0xe
	.uleb128 0x24
	.byte	0x84
	.uleb128 0x9
	.byte	0x85
	.uleb128 0x8
	.byte	0x86
	.uleb128 0x7
	.byte	0x87
	.uleb128 0x6
	.byte	0x88
	.uleb128 0x5
	.byte	0x89
	.uleb128 0x4
	.byte	0x8a
	.uleb128 0x3
	.byte	0x8b
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI49-.LCFI48
	.byte	0xe
	.uleb128 0xe0
	.byte	0x4
	.4byte	.LCFI50-.LCFI49
	.byte	0xe
	.uleb128 0x24
	.align	2
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.byte	0x4
	.4byte	.LCFI51-.LFB18
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	.LCFI52-.LCFI51
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.byte	0x4
	.4byte	.LCFI53-.LFB19
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI54-.LCFI53
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.byte	0x4
	.4byte	.LCFI55-.LFB20
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI56-.LCFI55
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.4byte	.LCFI57-.LCFI56
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x4
	.4byte	.LCFI58-.LFB21
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI59-.LCFI58
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI60-.LCFI59
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.byte	0x4
	.4byte	.LCFI61-.LFB22
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI62-.LCFI61
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI63-.LCFI62
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.byte	0x4
	.4byte	.LCFI64-.LFB23
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI65-.LCFI64
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.byte	0x4
	.4byte	.LCFI66-.LFB24
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI67-.LCFI66
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE48:
	.text
.Letext0:
	.file 2 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 5.32a/include/stdint.h"
	.file 3 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 5.32a/include/__crossworks.h"
	.file 4 "C:\\nordic\\nRF5_SDK_17.0.2_d674dde\\own_projects\\eigene\\twi_sensor2\\lib\\sensor\\snow_bme680\\bme680_defs.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x15c8
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF938
	.byte	0xc
	.4byte	.LASF939
	.4byte	.LASF940
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.4byte	.Ldebug_macro0
	.uleb128 0x2
	.4byte	.LASF702
	.byte	0x2
	.byte	0x29
	.byte	0x1c
	.4byte	0x35
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.4byte	.LASF704
	.uleb128 0x2
	.4byte	.LASF703
	.byte	0x2
	.byte	0x2a
	.byte	0x1c
	.4byte	0x4d
	.uleb128 0x4
	.4byte	0x3c
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF705
	.uleb128 0x4
	.4byte	0x4d
	.uleb128 0x2
	.4byte	.LASF706
	.byte	0x2
	.byte	0x2f
	.byte	0x1c
	.4byte	0x65
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.4byte	.LASF707
	.uleb128 0x2
	.4byte	.LASF708
	.byte	0x2
	.byte	0x30
	.byte	0x1c
	.4byte	0x78
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.4byte	.LASF709
	.uleb128 0x2
	.4byte	.LASF710
	.byte	0x2
	.byte	0x36
	.byte	0x1c
	.4byte	0x8b
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.4byte	.LASF711
	.byte	0x2
	.byte	0x37
	.byte	0x1c
	.4byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF712
	.uleb128 0x2
	.4byte	.LASF713
	.byte	0x2
	.byte	0x44
	.byte	0x1c
	.4byte	0xb1
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.4byte	.LASF714
	.uleb128 0x2
	.4byte	.LASF715
	.byte	0x2
	.byte	0x45
	.byte	0x1c
	.4byte	0xc4
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.4byte	.LASF716
	.uleb128 0x6
	.4byte	.LASF767
	.byte	0x8
	.byte	0x3
	.byte	0x7c
	.byte	0x8
	.4byte	0xf3
	.uleb128 0x7
	.4byte	.LASF717
	.byte	0x3
	.byte	0x7d
	.byte	0x7
	.4byte	0x8b
	.byte	0
	.uleb128 0x7
	.4byte	.LASF718
	.byte	0x3
	.byte	0x7e
	.byte	0x8
	.4byte	0xf3
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.4byte	.LASF719
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x113
	.uleb128 0x9
	.4byte	0x113
	.uleb128 0x9
	.4byte	0x9e
	.uleb128 0x9
	.4byte	0x125
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x119
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF720
	.uleb128 0x4
	.4byte	0x119
	.uleb128 0xa
	.byte	0x4
	.4byte	0xcb
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x149
	.uleb128 0x9
	.4byte	0x149
	.uleb128 0x9
	.4byte	0x14f
	.uleb128 0x9
	.4byte	0x9e
	.uleb128 0x9
	.4byte	0x125
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x9e
	.uleb128 0xa
	.byte	0x4
	.4byte	0x120
	.uleb128 0xb
	.byte	0x58
	.byte	0x3
	.byte	0x84
	.byte	0x9
	.4byte	0x2ff
	.uleb128 0x7
	.4byte	.LASF721
	.byte	0x3
	.byte	0x86
	.byte	0xf
	.4byte	0x14f
	.byte	0
	.uleb128 0x7
	.4byte	.LASF722
	.byte	0x3
	.byte	0x87
	.byte	0xf
	.4byte	0x14f
	.byte	0x4
	.uleb128 0x7
	.4byte	.LASF723
	.byte	0x3
	.byte	0x88
	.byte	0xf
	.4byte	0x14f
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF724
	.byte	0x3
	.byte	0x8a
	.byte	0xf
	.4byte	0x14f
	.byte	0xc
	.uleb128 0x7
	.4byte	.LASF725
	.byte	0x3
	.byte	0x8b
	.byte	0xf
	.4byte	0x14f
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF726
	.byte	0x3
	.byte	0x8c
	.byte	0xf
	.4byte	0x14f
	.byte	0x14
	.uleb128 0x7
	.4byte	.LASF727
	.byte	0x3
	.byte	0x8d
	.byte	0xf
	.4byte	0x14f
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF728
	.byte	0x3
	.byte	0x8e
	.byte	0xf
	.4byte	0x14f
	.byte	0x1c
	.uleb128 0x7
	.4byte	.LASF729
	.byte	0x3
	.byte	0x8f
	.byte	0xf
	.4byte	0x14f
	.byte	0x20
	.uleb128 0x7
	.4byte	.LASF730
	.byte	0x3
	.byte	0x90
	.byte	0xf
	.4byte	0x14f
	.byte	0x24
	.uleb128 0x7
	.4byte	.LASF731
	.byte	0x3
	.byte	0x92
	.byte	0x8
	.4byte	0x119
	.byte	0x28
	.uleb128 0x7
	.4byte	.LASF732
	.byte	0x3
	.byte	0x93
	.byte	0x8
	.4byte	0x119
	.byte	0x29
	.uleb128 0x7
	.4byte	.LASF733
	.byte	0x3
	.byte	0x94
	.byte	0x8
	.4byte	0x119
	.byte	0x2a
	.uleb128 0x7
	.4byte	.LASF734
	.byte	0x3
	.byte	0x95
	.byte	0x8
	.4byte	0x119
	.byte	0x2b
	.uleb128 0x7
	.4byte	.LASF735
	.byte	0x3
	.byte	0x96
	.byte	0x8
	.4byte	0x119
	.byte	0x2c
	.uleb128 0x7
	.4byte	.LASF736
	.byte	0x3
	.byte	0x97
	.byte	0x8
	.4byte	0x119
	.byte	0x2d
	.uleb128 0x7
	.4byte	.LASF737
	.byte	0x3
	.byte	0x98
	.byte	0x8
	.4byte	0x119
	.byte	0x2e
	.uleb128 0x7
	.4byte	.LASF738
	.byte	0x3
	.byte	0x99
	.byte	0x8
	.4byte	0x119
	.byte	0x2f
	.uleb128 0x7
	.4byte	.LASF739
	.byte	0x3
	.byte	0x9a
	.byte	0x8
	.4byte	0x119
	.byte	0x30
	.uleb128 0x7
	.4byte	.LASF740
	.byte	0x3
	.byte	0x9b
	.byte	0x8
	.4byte	0x119
	.byte	0x31
	.uleb128 0x7
	.4byte	.LASF741
	.byte	0x3
	.byte	0x9c
	.byte	0x8
	.4byte	0x119
	.byte	0x32
	.uleb128 0x7
	.4byte	.LASF742
	.byte	0x3
	.byte	0x9d
	.byte	0x8
	.4byte	0x119
	.byte	0x33
	.uleb128 0x7
	.4byte	.LASF743
	.byte	0x3
	.byte	0x9e
	.byte	0x8
	.4byte	0x119
	.byte	0x34
	.uleb128 0x7
	.4byte	.LASF744
	.byte	0x3
	.byte	0x9f
	.byte	0x8
	.4byte	0x119
	.byte	0x35
	.uleb128 0x7
	.4byte	.LASF745
	.byte	0x3
	.byte	0xa4
	.byte	0xf
	.4byte	0x14f
	.byte	0x38
	.uleb128 0x7
	.4byte	.LASF746
	.byte	0x3
	.byte	0xa5
	.byte	0xf
	.4byte	0x14f
	.byte	0x3c
	.uleb128 0x7
	.4byte	.LASF747
	.byte	0x3
	.byte	0xa6
	.byte	0xf
	.4byte	0x14f
	.byte	0x40
	.uleb128 0x7
	.4byte	.LASF748
	.byte	0x3
	.byte	0xa7
	.byte	0xf
	.4byte	0x14f
	.byte	0x44
	.uleb128 0x7
	.4byte	.LASF749
	.byte	0x3
	.byte	0xa8
	.byte	0xf
	.4byte	0x14f
	.byte	0x48
	.uleb128 0x7
	.4byte	.LASF750
	.byte	0x3
	.byte	0xa9
	.byte	0xf
	.4byte	0x14f
	.byte	0x4c
	.uleb128 0x7
	.4byte	.LASF751
	.byte	0x3
	.byte	0xaa
	.byte	0xf
	.4byte	0x14f
	.byte	0x50
	.uleb128 0x7
	.4byte	.LASF752
	.byte	0x3
	.byte	0xab
	.byte	0xf
	.4byte	0x14f
	.byte	0x54
	.byte	0
	.uleb128 0x2
	.4byte	.LASF753
	.byte	0x3
	.byte	0xac
	.byte	0x3
	.4byte	0x155
	.uleb128 0x4
	.4byte	0x2ff
	.uleb128 0xb
	.byte	0x20
	.byte	0x3
	.byte	0xc2
	.byte	0x9
	.4byte	0x382
	.uleb128 0x7
	.4byte	.LASF754
	.byte	0x3
	.byte	0xc4
	.byte	0x9
	.4byte	0x396
	.byte	0
	.uleb128 0x7
	.4byte	.LASF755
	.byte	0x3
	.byte	0xc5
	.byte	0x9
	.4byte	0x3ab
	.byte	0x4
	.uleb128 0x7
	.4byte	.LASF756
	.byte	0x3
	.byte	0xc6
	.byte	0x9
	.4byte	0x3ab
	.byte	0x8
	.uleb128 0x7
	.4byte	.LASF757
	.byte	0x3
	.byte	0xc9
	.byte	0x9
	.4byte	0x3c5
	.byte	0xc
	.uleb128 0x7
	.4byte	.LASF758
	.byte	0x3
	.byte	0xca
	.byte	0xa
	.4byte	0x3da
	.byte	0x10
	.uleb128 0x7
	.4byte	.LASF759
	.byte	0x3
	.byte	0xcb
	.byte	0xa
	.4byte	0x3da
	.byte	0x14
	.uleb128 0x7
	.4byte	.LASF760
	.byte	0x3
	.byte	0xce
	.byte	0x9
	.4byte	0x3e0
	.byte	0x18
	.uleb128 0x7
	.4byte	.LASF761
	.byte	0x3
	.byte	0xcf
	.byte	0x9
	.4byte	0x3e6
	.byte	0x1c
	.byte	0
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x396
	.uleb128 0x9
	.4byte	0x8b
	.uleb128 0x9
	.4byte	0x8b
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x382
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x3ab
	.uleb128 0x9
	.4byte	0x8b
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x39c
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x3c5
	.uleb128 0x9
	.4byte	0xf3
	.uleb128 0x9
	.4byte	0x8b
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x3b1
	.uleb128 0x8
	.4byte	0xf3
	.4byte	0x3da
	.uleb128 0x9
	.4byte	0xf3
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x3cb
	.uleb128 0xa
	.byte	0x4
	.4byte	0xfa
	.uleb128 0xa
	.byte	0x4
	.4byte	0x12b
	.uleb128 0x2
	.4byte	.LASF762
	.byte	0x3
	.byte	0xd0
	.byte	0x3
	.4byte	0x310
	.uleb128 0x4
	.4byte	0x3ec
	.uleb128 0xb
	.byte	0xc
	.byte	0x3
	.byte	0xd2
	.byte	0x9
	.4byte	0x42e
	.uleb128 0x7
	.4byte	.LASF763
	.byte	0x3
	.byte	0xd3
	.byte	0xf
	.4byte	0x14f
	.byte	0
	.uleb128 0x7
	.4byte	.LASF764
	.byte	0x3
	.byte	0xd4
	.byte	0x25
	.4byte	0x42e
	.byte	0x4
	.uleb128 0x7
	.4byte	.LASF765
	.byte	0x3
	.byte	0xd5
	.byte	0x28
	.4byte	0x434
	.byte	0x8
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x30b
	.uleb128 0xa
	.byte	0x4
	.4byte	0x3f8
	.uleb128 0x2
	.4byte	.LASF766
	.byte	0x3
	.byte	0xd6
	.byte	0x3
	.4byte	0x3fd
	.uleb128 0x4
	.4byte	0x43a
	.uleb128 0x6
	.4byte	.LASF768
	.byte	0x14
	.byte	0x3
	.byte	0xda
	.byte	0x10
	.4byte	0x466
	.uleb128 0x7
	.4byte	.LASF769
	.byte	0x3
	.byte	0xdb
	.byte	0x20
	.4byte	0x466
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x476
	.4byte	0x476
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x446
	.uleb128 0xe
	.4byte	.LASF770
	.byte	0x3
	.2byte	0x104
	.byte	0x1a
	.4byte	0x44b
	.uleb128 0xe
	.4byte	.LASF771
	.byte	0x3
	.2byte	0x10b
	.byte	0x24
	.4byte	0x446
	.uleb128 0xe
	.4byte	.LASF772
	.byte	0x3
	.2byte	0x10e
	.byte	0x2c
	.4byte	0x3f8
	.uleb128 0xe
	.4byte	.LASF773
	.byte	0x3
	.2byte	0x10f
	.byte	0x2c
	.4byte	0x3f8
	.uleb128 0xc
	.4byte	0x54
	.4byte	0x4c0
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x7f
	.byte	0
	.uleb128 0x4
	.4byte	0x4b0
	.uleb128 0xe
	.4byte	.LASF774
	.byte	0x3
	.2byte	0x111
	.byte	0x23
	.4byte	0x4c0
	.uleb128 0xc
	.4byte	0x120
	.4byte	0x4dd
	.uleb128 0xf
	.byte	0
	.uleb128 0x4
	.4byte	0x4d2
	.uleb128 0xe
	.4byte	.LASF775
	.byte	0x3
	.2byte	0x113
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF776
	.byte	0x3
	.2byte	0x114
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF777
	.byte	0x3
	.2byte	0x115
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF778
	.byte	0x3
	.2byte	0x116
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF779
	.byte	0x3
	.2byte	0x118
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF780
	.byte	0x3
	.2byte	0x119
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF781
	.byte	0x3
	.2byte	0x11a
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF782
	.byte	0x3
	.2byte	0x11b
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF783
	.byte	0x3
	.2byte	0x11c
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0xe
	.4byte	.LASF784
	.byte	0x3
	.2byte	0x11d
	.byte	0x13
	.4byte	0x4dd
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x573
	.uleb128 0x9
	.4byte	0x573
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x57e
	.uleb128 0x10
	.4byte	.LASF941
	.uleb128 0x4
	.4byte	0x579
	.uleb128 0xe
	.4byte	.LASF785
	.byte	0x3
	.2byte	0x133
	.byte	0xe
	.4byte	0x590
	.uleb128 0xa
	.byte	0x4
	.4byte	0x564
	.uleb128 0x8
	.4byte	0x8b
	.4byte	0x5a5
	.uleb128 0x9
	.4byte	0x5a5
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x579
	.uleb128 0xe
	.4byte	.LASF786
	.byte	0x3
	.2byte	0x134
	.byte	0xe
	.4byte	0x5b8
	.uleb128 0xa
	.byte	0x4
	.4byte	0x596
	.uleb128 0x11
	.4byte	.LASF787
	.byte	0x3
	.2byte	0x14b
	.byte	0x18
	.4byte	0x5cb
	.uleb128 0xa
	.byte	0x4
	.4byte	0x5d1
	.uleb128 0x8
	.4byte	0x14f
	.4byte	0x5e0
	.uleb128 0x9
	.4byte	0x8b
	.byte	0
	.uleb128 0x12
	.4byte	.LASF788
	.byte	0x8
	.byte	0x3
	.2byte	0x14d
	.byte	0x10
	.4byte	0x60b
	.uleb128 0x13
	.4byte	.LASF789
	.byte	0x3
	.2byte	0x14f
	.byte	0x1c
	.4byte	0x5be
	.byte	0
	.uleb128 0x13
	.4byte	.LASF790
	.byte	0x3
	.2byte	0x150
	.byte	0x21
	.4byte	0x60b
	.byte	0x4
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x5e0
	.uleb128 0x11
	.4byte	.LASF791
	.byte	0x3
	.2byte	0x151
	.byte	0x3
	.4byte	0x5e0
	.uleb128 0xe
	.4byte	.LASF792
	.byte	0x3
	.2byte	0x155
	.byte	0x1f
	.4byte	0x62b
	.uleb128 0xa
	.byte	0x4
	.4byte	0x611
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.4byte	.LASF793
	.uleb128 0x11
	.4byte	.LASF794
	.byte	0x4
	.2byte	0x159
	.byte	0x12
	.4byte	0x645
	.uleb128 0xa
	.byte	0x4
	.4byte	0x64b
	.uleb128 0x8
	.4byte	0x29
	.4byte	0x669
	.uleb128 0x9
	.4byte	0x3c
	.uleb128 0x9
	.4byte	0x3c
	.uleb128 0x9
	.4byte	0x669
	.uleb128 0x9
	.4byte	0x6c
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x3c
	.uleb128 0x11
	.4byte	.LASF795
	.byte	0x4
	.2byte	0x15f
	.byte	0x10
	.4byte	0x67c
	.uleb128 0xa
	.byte	0x4
	.4byte	0x682
	.uleb128 0x14
	.4byte	0x68d
	.uleb128 0x9
	.4byte	0x92
	.byte	0
	.uleb128 0x15
	.4byte	.LASF942
	.byte	0x7
	.byte	0x1
	.4byte	0x4d
	.byte	0x4
	.2byte	0x164
	.byte	0x6
	.4byte	0x6ad
	.uleb128 0x16
	.4byte	.LASF796
	.byte	0
	.uleb128 0x16
	.4byte	.LASF797
	.byte	0x1
	.byte	0
	.uleb128 0x12
	.4byte	.LASF798
	.byte	0x14
	.byte	0x4
	.2byte	0x16f
	.byte	0x8
	.4byte	0x71e
	.uleb128 0x13
	.4byte	.LASF799
	.byte	0x4
	.2byte	0x171
	.byte	0xa
	.4byte	0x3c
	.byte	0
	.uleb128 0x13
	.4byte	.LASF800
	.byte	0x4
	.2byte	0x173
	.byte	0xa
	.4byte	0x3c
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF801
	.byte	0x4
	.2byte	0x175
	.byte	0xa
	.4byte	0x3c
	.byte	0x2
	.uleb128 0x13
	.4byte	.LASF802
	.byte	0x4
	.2byte	0x179
	.byte	0xa
	.4byte	0x59
	.byte	0x4
	.uleb128 0x13
	.4byte	.LASF803
	.byte	0x4
	.2byte	0x17b
	.byte	0xb
	.4byte	0x92
	.byte	0x8
	.uleb128 0x13
	.4byte	.LASF804
	.byte	0x4
	.2byte	0x17d
	.byte	0xb
	.4byte	0x92
	.byte	0xc
	.uleb128 0x13
	.4byte	.LASF805
	.byte	0x4
	.2byte	0x17f
	.byte	0xb
	.4byte	0x92
	.byte	0x10
	.byte	0
	.uleb128 0x12
	.4byte	.LASF806
	.byte	0x30
	.byte	0x4
	.2byte	0x191
	.byte	0x8
	.4byte	0x8a7
	.uleb128 0x13
	.4byte	.LASF807
	.byte	0x4
	.2byte	0x193
	.byte	0xb
	.4byte	0x6c
	.byte	0
	.uleb128 0x13
	.4byte	.LASF808
	.byte	0x4
	.2byte	0x195
	.byte	0xb
	.4byte	0x6c
	.byte	0x2
	.uleb128 0x13
	.4byte	.LASF809
	.byte	0x4
	.2byte	0x197
	.byte	0x9
	.4byte	0x29
	.byte	0x4
	.uleb128 0x13
	.4byte	.LASF810
	.byte	0x4
	.2byte	0x199
	.byte	0x9
	.4byte	0x29
	.byte	0x5
	.uleb128 0x13
	.4byte	.LASF811
	.byte	0x4
	.2byte	0x19b
	.byte	0x9
	.4byte	0x29
	.byte	0x6
	.uleb128 0x13
	.4byte	.LASF812
	.byte	0x4
	.2byte	0x19d
	.byte	0xa
	.4byte	0x3c
	.byte	0x7
	.uleb128 0x13
	.4byte	.LASF813
	.byte	0x4
	.2byte	0x19f
	.byte	0x9
	.4byte	0x29
	.byte	0x8
	.uleb128 0x13
	.4byte	.LASF814
	.byte	0x4
	.2byte	0x1a1
	.byte	0x9
	.4byte	0x29
	.byte	0x9
	.uleb128 0x13
	.4byte	.LASF815
	.byte	0x4
	.2byte	0x1a3
	.byte	0xa
	.4byte	0x59
	.byte	0xa
	.uleb128 0x13
	.4byte	.LASF816
	.byte	0x4
	.2byte	0x1a5
	.byte	0x9
	.4byte	0x29
	.byte	0xc
	.uleb128 0x13
	.4byte	.LASF817
	.byte	0x4
	.2byte	0x1a7
	.byte	0xb
	.4byte	0x6c
	.byte	0xe
	.uleb128 0x13
	.4byte	.LASF818
	.byte	0x4
	.2byte	0x1a9
	.byte	0xa
	.4byte	0x59
	.byte	0x10
	.uleb128 0x13
	.4byte	.LASF819
	.byte	0x4
	.2byte	0x1ab
	.byte	0x9
	.4byte	0x29
	.byte	0x12
	.uleb128 0x13
	.4byte	.LASF820
	.byte	0x4
	.2byte	0x1ad
	.byte	0xb
	.4byte	0x6c
	.byte	0x14
	.uleb128 0x13
	.4byte	.LASF821
	.byte	0x4
	.2byte	0x1af
	.byte	0xa
	.4byte	0x59
	.byte	0x16
	.uleb128 0x13
	.4byte	.LASF822
	.byte	0x4
	.2byte	0x1b1
	.byte	0x9
	.4byte	0x29
	.byte	0x18
	.uleb128 0x13
	.4byte	.LASF823
	.byte	0x4
	.2byte	0x1b3
	.byte	0xa
	.4byte	0x59
	.byte	0x1a
	.uleb128 0x13
	.4byte	.LASF824
	.byte	0x4
	.2byte	0x1b5
	.byte	0xa
	.4byte	0x59
	.byte	0x1c
	.uleb128 0x13
	.4byte	.LASF825
	.byte	0x4
	.2byte	0x1b7
	.byte	0x9
	.4byte	0x29
	.byte	0x1e
	.uleb128 0x13
	.4byte	.LASF826
	.byte	0x4
	.2byte	0x1b9
	.byte	0x9
	.4byte	0x29
	.byte	0x1f
	.uleb128 0x13
	.4byte	.LASF827
	.byte	0x4
	.2byte	0x1bb
	.byte	0xa
	.4byte	0x59
	.byte	0x20
	.uleb128 0x13
	.4byte	.LASF828
	.byte	0x4
	.2byte	0x1bd
	.byte	0xa
	.4byte	0x59
	.byte	0x22
	.uleb128 0x13
	.4byte	.LASF829
	.byte	0x4
	.2byte	0x1bf
	.byte	0xa
	.4byte	0x3c
	.byte	0x24
	.uleb128 0x13
	.4byte	.LASF830
	.byte	0x4
	.2byte	0x1c3
	.byte	0xa
	.4byte	0x7f
	.byte	0x28
	.uleb128 0x13
	.4byte	.LASF831
	.byte	0x4
	.2byte	0x1c9
	.byte	0xa
	.4byte	0x3c
	.byte	0x2c
	.uleb128 0x13
	.4byte	.LASF832
	.byte	0x4
	.2byte	0x1cb
	.byte	0x9
	.4byte	0x29
	.byte	0x2d
	.uleb128 0x13
	.4byte	.LASF833
	.byte	0x4
	.2byte	0x1cd
	.byte	0x9
	.4byte	0x29
	.byte	0x2e
	.byte	0
	.uleb128 0x12
	.4byte	.LASF834
	.byte	0x4
	.byte	0x4
	.2byte	0x1d4
	.byte	0x8
	.4byte	0x8ee
	.uleb128 0x13
	.4byte	.LASF835
	.byte	0x4
	.2byte	0x1d6
	.byte	0xa
	.4byte	0x3c
	.byte	0
	.uleb128 0x13
	.4byte	.LASF836
	.byte	0x4
	.2byte	0x1d8
	.byte	0xa
	.4byte	0x3c
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF837
	.byte	0x4
	.2byte	0x1da
	.byte	0xa
	.4byte	0x3c
	.byte	0x2
	.uleb128 0x13
	.4byte	.LASF838
	.byte	0x4
	.2byte	0x1dc
	.byte	0xa
	.4byte	0x3c
	.byte	0x3
	.byte	0
	.uleb128 0x12
	.4byte	.LASF839
	.byte	0x8
	.byte	0x4
	.2byte	0x1e3
	.byte	0x8
	.4byte	0x943
	.uleb128 0x13
	.4byte	.LASF840
	.byte	0x4
	.2byte	0x1e5
	.byte	0xa
	.4byte	0x3c
	.byte	0
	.uleb128 0x13
	.4byte	.LASF841
	.byte	0x4
	.2byte	0x1e7
	.byte	0xa
	.4byte	0x3c
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF842
	.byte	0x4
	.2byte	0x1e9
	.byte	0xa
	.4byte	0x3c
	.byte	0x2
	.uleb128 0x13
	.4byte	.LASF843
	.byte	0x4
	.2byte	0x1eb
	.byte	0xb
	.4byte	0x6c
	.byte	0x4
	.uleb128 0x13
	.4byte	.LASF844
	.byte	0x4
	.2byte	0x1ed
	.byte	0xb
	.4byte	0x6c
	.byte	0x6
	.byte	0
	.uleb128 0x12
	.4byte	.LASF845
	.byte	0x58
	.byte	0x4
	.2byte	0x1f3
	.byte	0x8
	.4byte	0xa24
	.uleb128 0x13
	.4byte	.LASF846
	.byte	0x4
	.2byte	0x1f5
	.byte	0xa
	.4byte	0x3c
	.byte	0
	.uleb128 0x13
	.4byte	.LASF847
	.byte	0x4
	.2byte	0x1f7
	.byte	0xa
	.4byte	0x3c
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF848
	.byte	0x4
	.2byte	0x1f9
	.byte	0x13
	.4byte	0x68d
	.byte	0x2
	.uleb128 0x13
	.4byte	.LASF849
	.byte	0x4
	.2byte	0x1fb
	.byte	0xa
	.4byte	0x3c
	.byte	0x3
	.uleb128 0x13
	.4byte	.LASF850
	.byte	0x4
	.2byte	0x1fd
	.byte	0x9
	.4byte	0x29
	.byte	0x4
	.uleb128 0x13
	.4byte	.LASF851
	.byte	0x4
	.2byte	0x1ff
	.byte	0x1b
	.4byte	0x71e
	.byte	0x8
	.uleb128 0x13
	.4byte	.LASF852
	.byte	0x4
	.2byte	0x201
	.byte	0x19
	.4byte	0x8a7
	.byte	0x38
	.uleb128 0x13
	.4byte	.LASF853
	.byte	0x4
	.2byte	0x203
	.byte	0x19
	.4byte	0x8ee
	.byte	0x3c
	.uleb128 0x13
	.4byte	.LASF854
	.byte	0x4
	.2byte	0x205
	.byte	0xa
	.4byte	0x3c
	.byte	0x44
	.uleb128 0x13
	.4byte	.LASF855
	.byte	0x4
	.2byte	0x207
	.byte	0xa
	.4byte	0x3c
	.byte	0x45
	.uleb128 0x13
	.4byte	.LASF856
	.byte	0x4
	.2byte	0x209
	.byte	0xa
	.4byte	0x3c
	.byte	0x46
	.uleb128 0x13
	.4byte	.LASF857
	.byte	0x4
	.2byte	0x20b
	.byte	0x14
	.4byte	0x638
	.byte	0x48
	.uleb128 0x13
	.4byte	.LASF858
	.byte	0x4
	.2byte	0x20d
	.byte	0x14
	.4byte	0x638
	.byte	0x4c
	.uleb128 0x13
	.4byte	.LASF859
	.byte	0x4
	.2byte	0x20f
	.byte	0x16
	.4byte	0x66f
	.byte	0x50
	.uleb128 0x13
	.4byte	.LASF860
	.byte	0x4
	.2byte	0x211
	.byte	0x9
	.4byte	0x29
	.byte	0x54
	.byte	0
	.uleb128 0x4
	.4byte	0x943
	.uleb128 0x17
	.4byte	.LASF861
	.byte	0x1
	.2byte	0x541
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xa65
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x541
	.byte	0x37
	.4byte	0xa65
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x543
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -1
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0xa24
	.uleb128 0x17
	.4byte	.LASF862
	.byte	0x1
	.2byte	0x525
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xad7
	.uleb128 0x1a
	.4byte	.LASF863
	.byte	0x1
	.2byte	0x525
	.byte	0x27
	.4byte	0x669
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x18
	.ascii	"min\000"
	.byte	0x1
	.2byte	0x525
	.byte	0x36
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.uleb128 0x18
	.ascii	"max\000"
	.byte	0x1
	.2byte	0x525
	.byte	0x43
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x525
	.byte	0x5b
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x527
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -1
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x943
	.uleb128 0x1b
	.4byte	.LASF865
	.byte	0x1
	.2byte	0x50f
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb29
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x50f
	.byte	0x2f
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x511
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x1c
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x512
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF866
	.byte	0x1
	.2byte	0x4e8
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xb95
	.uleb128 0x1a
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x4e8
	.byte	0x24
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x4e8
	.byte	0x41
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x4ea
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x1c
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x4eb
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.uleb128 0x19
	.4byte	.LASF849
	.byte	0x1
	.2byte	0x4ec
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF868
	.byte	0x1
	.2byte	0x4b0
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc51
	.uleb128 0x1a
	.4byte	.LASF764
	.byte	0x1
	.2byte	0x4b0
	.byte	0x39
	.4byte	0xc51
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x4b0
	.byte	0x52
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x4b2
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF869
	.byte	0x1
	.2byte	0x4b3
	.byte	0xa
	.4byte	0xc57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.4byte	.LASF870
	.byte	0x1
	.2byte	0x4b4
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x19
	.4byte	.LASF871
	.byte	0x1
	.2byte	0x4b5
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF872
	.byte	0x1
	.2byte	0x4b6
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF873
	.byte	0x1
	.2byte	0x4b7
	.byte	0xb
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x19
	.4byte	.LASF874
	.byte	0x1
	.2byte	0x4b8
	.byte	0xb
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF875
	.byte	0x1
	.2byte	0x4b9
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x6ad
	.uleb128 0xc
	.4byte	0x3c
	.4byte	0xc67
	.uleb128 0xd
	.4byte	0x9e
	.byte	0xe
	.byte	0
	.uleb128 0x17
	.4byte	.LASF876
	.byte	0x1
	.2byte	0x49b
	.byte	0x10
	.4byte	0x3c
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xcb3
	.uleb128 0x18
	.ascii	"dur\000"
	.byte	0x1
	.2byte	0x49b
	.byte	0x29
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF877
	.byte	0x1
	.2byte	0x49d
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -1
	.uleb128 0x19
	.4byte	.LASF878
	.byte	0x1
	.2byte	0x49e
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -2
	.byte	0
	.uleb128 0x17
	.4byte	.LASF879
	.byte	0x1
	.2byte	0x3e1
	.byte	0x10
	.4byte	0x3c
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xd5f
	.uleb128 0x1a
	.4byte	.LASF880
	.byte	0x1
	.2byte	0x3e1
	.byte	0x29
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x3e1
	.byte	0x48
	.4byte	0xa65
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.4byte	.LASF881
	.byte	0x1
	.2byte	0x3e3
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x19
	.4byte	.LASF882
	.byte	0x1
	.2byte	0x3e4
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x19
	.4byte	.LASF883
	.byte	0x1
	.2byte	0x3e5
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF884
	.byte	0x1
	.2byte	0x3e6
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF885
	.byte	0x1
	.2byte	0x3e7
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF886
	.byte	0x1
	.2byte	0x3e8
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF887
	.byte	0x1
	.2byte	0x3e9
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF888
	.byte	0x1
	.2byte	0x3c4
	.byte	0x11
	.4byte	0x92
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe11
	.uleb128 0x1a
	.4byte	.LASF889
	.byte	0x1
	.2byte	0x3c4
	.byte	0x2e
	.4byte	0x6c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -202
	.uleb128 0x1a
	.4byte	.LASF870
	.byte	0x1
	.2byte	0x3c4
	.byte	0x43
	.4byte	0x3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -203
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x3c4
	.byte	0x67
	.4byte	0xa65
	.uleb128 0x3
	.byte	0x91
	.sleb128 -208
	.uleb128 0x19
	.4byte	.LASF882
	.byte	0x1
	.2byte	0x3c6
	.byte	0xa
	.4byte	0xa5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x19
	.4byte	.LASF883
	.byte	0x1
	.2byte	0x3c7
	.byte	0xb
	.4byte	0xb8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x19
	.4byte	.LASF884
	.byte	0x1
	.2byte	0x3c8
	.byte	0xa
	.4byte	0xa5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x19
	.4byte	.LASF890
	.byte	0x1
	.2byte	0x3c9
	.byte	0xb
	.4byte	0x92
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x19
	.4byte	.LASF891
	.byte	0x1
	.2byte	0x3cb
	.byte	0xb
	.4byte	0xe11
	.uleb128 0x3
	.byte	0x91
	.sleb128 -132
	.uleb128 0x19
	.4byte	.LASF892
	.byte	0x1
	.2byte	0x3d0
	.byte	0xb
	.4byte	0xe11
	.uleb128 0x3
	.byte	0x91
	.sleb128 -196
	.byte	0
	.uleb128 0xc
	.4byte	0x92
	.4byte	0xe21
	.uleb128 0xd
	.4byte	0x9e
	.byte	0xf
	.byte	0
	.uleb128 0x17
	.4byte	.LASF893
	.byte	0x1
	.2byte	0x3a0
	.byte	0x11
	.4byte	0x92
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xedd
	.uleb128 0x1a
	.4byte	.LASF894
	.byte	0x1
	.2byte	0x3a0
	.byte	0x28
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x3a0
	.byte	0x4a
	.4byte	0xa65
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.4byte	.LASF882
	.byte	0x1
	.2byte	0x3a2
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF883
	.byte	0x1
	.2byte	0x3a3
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF884
	.byte	0x1
	.2byte	0x3a4
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF885
	.byte	0x1
	.2byte	0x3a5
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF886
	.byte	0x1
	.2byte	0x3a6
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.4byte	.LASF895
	.byte	0x1
	.2byte	0x3a7
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.4byte	.LASF896
	.byte	0x1
	.2byte	0x3a8
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF897
	.byte	0x1
	.2byte	0x3a9
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x17
	.4byte	.LASF898
	.byte	0x1
	.2byte	0x377
	.byte	0x11
	.4byte	0x92
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xf59
	.uleb128 0x1a
	.4byte	.LASF899
	.byte	0x1
	.2byte	0x377
	.byte	0x28
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x377
	.byte	0x4b
	.4byte	0xa65
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF882
	.byte	0x1
	.2byte	0x379
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF883
	.byte	0x1
	.2byte	0x37a
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF884
	.byte	0x1
	.2byte	0x37b
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF900
	.byte	0x1
	.2byte	0x37c
	.byte	0xa
	.4byte	0x7f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.uleb128 0x17
	.4byte	.LASF901
	.byte	0x1
	.2byte	0x363
	.byte	0x10
	.4byte	0x59
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xfd5
	.uleb128 0x1a
	.4byte	.LASF902
	.byte	0x1
	.2byte	0x363
	.byte	0x2a
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x363
	.byte	0x47
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x19
	.4byte	.LASF882
	.byte	0x1
	.2byte	0x365
	.byte	0xa
	.4byte	0xa5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF883
	.byte	0x1
	.2byte	0x366
	.byte	0xa
	.4byte	0xa5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF884
	.byte	0x1
	.2byte	0x367
	.byte	0xa
	.4byte	0xa5
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.4byte	.LASF903
	.byte	0x1
	.2byte	0x368
	.byte	0xa
	.4byte	0x59
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF904
	.byte	0x1
	.2byte	0x33e
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1041
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x33e
	.byte	0x31
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x340
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF905
	.byte	0x1
	.2byte	0x342
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF906
	.byte	0x1
	.2byte	0x343
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.uleb128 0x19
	.4byte	.LASF907
	.byte	0x1
	.2byte	0x344
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF908
	.byte	0x1
	.2byte	0x31e
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10a7
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x31e
	.byte	0x31
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x320
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x1d
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.uleb128 0x19
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x326
	.byte	0xb
	.4byte	0x10a7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF907
	.byte	0x1
	.2byte	0x327
	.byte	0xb
	.4byte	0x10a7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x3c
	.4byte	0x10b7
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x1
	.byte	0
	.uleb128 0x1b
	.4byte	.LASF909
	.byte	0x1
	.2byte	0x2cf
	.byte	0xf
	.4byte	0x29
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1113
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x2cf
	.byte	0x31
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x2d1
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF910
	.byte	0x1
	.2byte	0x2d2
	.byte	0xa
	.4byte	0x1113
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x19
	.4byte	.LASF911
	.byte	0x1
	.2byte	0x2d3
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -53
	.byte	0
	.uleb128 0xc
	.4byte	0x3c
	.4byte	0x1123
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x28
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF918
	.byte	0x1
	.2byte	0x2b8
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x116f
	.uleb128 0x1a
	.4byte	.LASF764
	.byte	0x1
	.2byte	0x2b8
	.byte	0x39
	.4byte	0xc51
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x2b8
	.byte	0x52
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x2ba
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF916
	.byte	0x1
	.2byte	0x297
	.byte	0x6
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x11d7
	.uleb128 0x1a
	.4byte	.LASF912
	.byte	0x1
	.2byte	0x297
	.byte	0x27
	.4byte	0x11d7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x297
	.byte	0x4a
	.4byte	0xa65
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF913
	.byte	0x1
	.2byte	0x299
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF914
	.byte	0x1
	.2byte	0x29a
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x19
	.4byte	.LASF915
	.byte	0x1
	.2byte	0x29b
	.byte	0xa
	.4byte	0x11dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x6c
	.uleb128 0xc
	.4byte	0x3c
	.4byte	0x11ed
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x5
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF917
	.byte	0x1
	.2byte	0x27e
	.byte	0x6
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1255
	.uleb128 0x1a
	.4byte	.LASF912
	.byte	0x1
	.2byte	0x27e
	.byte	0x26
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x27e
	.byte	0x43
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF913
	.byte	0x1
	.2byte	0x280
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF914
	.byte	0x1
	.2byte	0x281
	.byte	0xb
	.4byte	0x92
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x19
	.4byte	.LASF915
	.byte	0x1
	.2byte	0x282
	.byte	0xa
	.4byte	0x11dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF919
	.byte	0x1
	.2byte	0x26b
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x12a1
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x26b
	.byte	0x32
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x26d
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF920
	.byte	0x1
	.2byte	0x26e
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF921
	.byte	0x1
	.2byte	0x244
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x130d
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x244
	.byte	0x32
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x246
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF922
	.byte	0x1
	.2byte	0x247
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.uleb128 0x19
	.4byte	.LASF923
	.byte	0x1
	.2byte	0x248
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x249
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF924
	.byte	0x1
	.2byte	0x210
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1379
	.uleb128 0x1a
	.4byte	.LASF925
	.byte	0x1
	.2byte	0x210
	.byte	0x2c
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x210
	.byte	0x51
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x212
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x214
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF926
	.byte	0x1
	.2byte	0x215
	.byte	0xa
	.4byte	0x11dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF927
	.byte	0x1
	.2byte	0x194
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1425
	.uleb128 0x1a
	.4byte	.LASF925
	.byte	0x1
	.2byte	0x194
	.byte	0x2c
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x194
	.byte	0x51
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x196
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x197
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF764
	.byte	0x1
	.2byte	0x198
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.uleb128 0x19
	.4byte	.LASF928
	.byte	0x1
	.2byte	0x199
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF929
	.byte	0x1
	.2byte	0x19a
	.byte	0xa
	.4byte	0x11dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF926
	.byte	0x1
	.2byte	0x19b
	.byte	0xa
	.4byte	0x11dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.4byte	.LASF930
	.byte	0x1
	.2byte	0x19c
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF931
	.byte	0x1
	.2byte	0x172
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1481
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x172
	.byte	0x2d
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x174
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x19
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x175
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF932
	.byte	0x1
	.2byte	0x177
	.byte	0xa
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF933
	.byte	0x1
	.2byte	0x14b
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1511
	.uleb128 0x1a
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x14b
	.byte	0x27
	.4byte	0x1511
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x1a
	.4byte	.LASF907
	.byte	0x1
	.2byte	0x14b
	.byte	0x40
	.4byte	0x1511
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x18
	.ascii	"len\000"
	.byte	0x1
	.2byte	0x14b
	.byte	0x52
	.4byte	0x3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -73
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x14b
	.byte	0x6a
	.4byte	0xad7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x14d
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x19
	.4byte	.LASF934
	.byte	0x1
	.2byte	0x14f
	.byte	0xa
	.4byte	0x1517
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x19
	.4byte	.LASF935
	.byte	0x1
	.2byte	0x150
	.byte	0xb
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x48
	.uleb128 0xc
	.4byte	0x3c
	.4byte	0x1527
	.uleb128 0xd
	.4byte	0x9e
	.byte	0x27
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF936
	.byte	0x1
	.2byte	0x132
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1593
	.uleb128 0x1a
	.4byte	.LASF867
	.byte	0x1
	.2byte	0x132
	.byte	0x20
	.4byte	0x3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.4byte	.LASF907
	.byte	0x1
	.2byte	0x132
	.byte	0x33
	.4byte	0x669
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.ascii	"len\000"
	.byte	0x1
	.2byte	0x132
	.byte	0x46
	.4byte	0x6c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x132
	.byte	0x5e
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x134
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x20
	.4byte	.LASF937
	.byte	0x1
	.2byte	0x116
	.byte	0x8
	.4byte	0x29
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x18
	.ascii	"dev\000"
	.byte	0x1
	.2byte	0x116
	.byte	0x27
	.4byte	0xad7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF864
	.byte	0x1
	.2byte	0x118
	.byte	0x9
	.4byte	0x29
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x2134
	.uleb128 0x19
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.uleb128 0x2119
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x257
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x15cc
	.4byte	0x6a0
	.ascii	"BME680_SPI_INTF\000"
	.4byte	0x6a6
	.ascii	"BME680_I2C_INTF\000"
	.4byte	0xa29
	.ascii	"null_ptr_check\000"
	.4byte	0xa6b
	.ascii	"boundary_check\000"
	.4byte	0xadd
	.ascii	"get_mem_page\000"
	.4byte	0xb29
	.ascii	"set_mem_page\000"
	.4byte	0xb95
	.ascii	"read_field_data\000"
	.4byte	0xc67
	.ascii	"calc_heater_dur\000"
	.4byte	0xcb3
	.ascii	"calc_heater_res\000"
	.4byte	0xd5f
	.ascii	"calc_gas_resistance\000"
	.4byte	0xe21
	.ascii	"calc_humidity\000"
	.4byte	0xedd
	.ascii	"calc_pressure\000"
	.4byte	0xf59
	.ascii	"calc_temperature\000"
	.4byte	0xfd5
	.ascii	"get_gas_config\000"
	.4byte	0x1041
	.ascii	"set_gas_config\000"
	.4byte	0x10b7
	.ascii	"get_calib_data\000"
	.4byte	0x1123
	.ascii	"bme680_get_sensor_data\000"
	.4byte	0x116f
	.ascii	"bme680_get_profile_dur\000"
	.4byte	0x11ed
	.ascii	"bme680_set_profile_dur\000"
	.4byte	0x1255
	.ascii	"bme680_get_sensor_mode\000"
	.4byte	0x12a1
	.ascii	"bme680_set_sensor_mode\000"
	.4byte	0x130d
	.ascii	"bme680_get_sensor_settings\000"
	.4byte	0x1379
	.ascii	"bme680_set_sensor_settings\000"
	.4byte	0x1425
	.ascii	"bme680_soft_reset\000"
	.4byte	0x1481
	.ascii	"bme680_set_regs\000"
	.4byte	0x1527
	.ascii	"bme680_get_regs\000"
	.4byte	0x1593
	.ascii	"bme680_init\000"
	.4byte	0
	.section	.debug_pubtypes,"",%progbits
	.4byte	0x27a
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x15cc
	.4byte	0x35
	.ascii	"signed char\000"
	.4byte	0x29
	.ascii	"int8_t\000"
	.4byte	0x4d
	.ascii	"unsigned char\000"
	.4byte	0x3c
	.ascii	"uint8_t\000"
	.4byte	0x65
	.ascii	"short int\000"
	.4byte	0x59
	.ascii	"int16_t\000"
	.4byte	0x78
	.ascii	"short unsigned int\000"
	.4byte	0x6c
	.ascii	"uint16_t\000"
	.4byte	0x8b
	.ascii	"int\000"
	.4byte	0x7f
	.ascii	"int32_t\000"
	.4byte	0x9e
	.ascii	"unsigned int\000"
	.4byte	0x92
	.ascii	"uint32_t\000"
	.4byte	0xb1
	.ascii	"long long int\000"
	.4byte	0xa5
	.ascii	"int64_t\000"
	.4byte	0xc4
	.ascii	"long long unsigned int\000"
	.4byte	0xb8
	.ascii	"uint64_t\000"
	.4byte	0xf3
	.ascii	"long int\000"
	.4byte	0xcb
	.ascii	"__mbstate_s\000"
	.4byte	0x119
	.ascii	"char\000"
	.4byte	0x2ff
	.ascii	"__RAL_locale_data_t\000"
	.4byte	0x3ec
	.ascii	"__RAL_locale_codeset_t\000"
	.4byte	0x43a
	.ascii	"__RAL_locale_t\000"
	.4byte	0x44b
	.ascii	"__locale_s\000"
	.4byte	0x5be
	.ascii	"__RAL_error_decoder_fn_t\000"
	.4byte	0x5e0
	.ascii	"__RAL_error_decoder_s\000"
	.4byte	0x611
	.ascii	"__RAL_error_decoder_t\000"
	.4byte	0x631
	.ascii	"long double\000"
	.4byte	0x638
	.ascii	"bme680_com_fptr_t\000"
	.4byte	0x66f
	.ascii	"bme680_delay_fptr_t\000"
	.4byte	0x68d
	.ascii	"bme680_intf\000"
	.4byte	0x6ad
	.ascii	"bme680_field_data\000"
	.4byte	0x71e
	.ascii	"bme680_calib_data\000"
	.4byte	0x8a7
	.ascii	"bme680_tph_sett\000"
	.4byte	0x8ee
	.ascii	"bme680_gas_sett\000"
	.4byte	0x943
	.ascii	"bme680_dev\000"
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0xdc
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	.LFB1
	.4byte	.LFE1
	.4byte	.LFB2
	.4byte	.LFE2
	.4byte	.LFB3
	.4byte	.LFE3
	.4byte	.LFB4
	.4byte	.LFE4
	.4byte	.LFB5
	.4byte	.LFE5
	.4byte	.LFB6
	.4byte	.LFE6
	.4byte	.LFB7
	.4byte	.LFE7
	.4byte	.LFB8
	.4byte	.LFE8
	.4byte	.LFB9
	.4byte	.LFE9
	.4byte	.LFB10
	.4byte	.LFE10
	.4byte	.LFB11
	.4byte	.LFE11
	.4byte	.LFB12
	.4byte	.LFE12
	.4byte	.LFB13
	.4byte	.LFE13
	.4byte	.LFB14
	.4byte	.LFE14
	.4byte	.LFB15
	.4byte	.LFE15
	.4byte	.LFB16
	.4byte	.LFE16
	.4byte	.LFB17
	.4byte	.LFE17
	.4byte	.LFB18
	.4byte	.LFE18
	.4byte	.LFB19
	.4byte	.LFE19
	.4byte	.LFB20
	.4byte	.LFE20
	.4byte	.LFB21
	.4byte	.LFE21
	.4byte	.LFB22
	.4byte	.LFE22
	.4byte	.LFB23
	.4byte	.LFE23
	.4byte	.LFB24
	.4byte	.LFE24
	.4byte	0
	.4byte	0
	.section	.debug_macro,"",%progbits
.Ldebug_macro0:
	.2byte	0x4
	.byte	0x2
	.4byte	.Ldebug_line0
	.byte	0x7
	.4byte	.Ldebug_macro2
	.byte	0x3
	.uleb128 0
	.uleb128 0x1
	.file 5 "C:\\nordic\\nRF5_SDK_17.0.2_d674dde\\own_projects\\eigene\\twi_sensor2\\lib\\sensor\\snow_bme680\\bme680.h"
	.byte	0x3
	.uleb128 0x29
	.uleb128 0x5
	.byte	0x5
	.uleb128 0x2d
	.4byte	.LASF464
	.byte	0x3
	.uleb128 0x36
	.uleb128 0x4
	.byte	0x5
	.uleb128 0x2f
	.4byte	.LASF465
	.byte	0x3
	.uleb128 0x37
	.uleb128 0x2
	.byte	0x7
	.4byte	.Ldebug_macro3
	.byte	0x4
	.file 6 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 5.32a/include/stddef.h"
	.byte	0x3
	.uleb128 0x38
	.uleb128 0x6
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF526
	.byte	0x3
	.uleb128 0x29
	.uleb128 0x3
	.byte	0x7
	.4byte	.Ldebug_macro4
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro5
	.byte	0x4
	.byte	0x7
	.4byte	.Ldebug_macro6
	.byte	0x4
	.byte	0x4
	.byte	0x4
	.byte	0
	.section	.debug_macro,"G",%progbits,wm4.0.2eec61a79c14f47692b4a63025470323,comdat
.Ldebug_macro2:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF0
	.byte	0x5
	.uleb128 0
	.4byte	.LASF1
	.byte	0x5
	.uleb128 0
	.4byte	.LASF2
	.byte	0x5
	.uleb128 0
	.4byte	.LASF3
	.byte	0x5
	.uleb128 0
	.4byte	.LASF4
	.byte	0x5
	.uleb128 0
	.4byte	.LASF5
	.byte	0x5
	.uleb128 0
	.4byte	.LASF6
	.byte	0x5
	.uleb128 0
	.4byte	.LASF7
	.byte	0x5
	.uleb128 0
	.4byte	.LASF8
	.byte	0x5
	.uleb128 0
	.4byte	.LASF9
	.byte	0x5
	.uleb128 0
	.4byte	.LASF10
	.byte	0x5
	.uleb128 0
	.4byte	.LASF11
	.byte	0x5
	.uleb128 0
	.4byte	.LASF12
	.byte	0x5
	.uleb128 0
	.4byte	.LASF13
	.byte	0x5
	.uleb128 0
	.4byte	.LASF14
	.byte	0x5
	.uleb128 0
	.4byte	.LASF15
	.byte	0x5
	.uleb128 0
	.4byte	.LASF16
	.byte	0x5
	.uleb128 0
	.4byte	.LASF17
	.byte	0x5
	.uleb128 0
	.4byte	.LASF18
	.byte	0x5
	.uleb128 0
	.4byte	.LASF19
	.byte	0x5
	.uleb128 0
	.4byte	.LASF20
	.byte	0x5
	.uleb128 0
	.4byte	.LASF21
	.byte	0x5
	.uleb128 0
	.4byte	.LASF22
	.byte	0x5
	.uleb128 0
	.4byte	.LASF23
	.byte	0x5
	.uleb128 0
	.4byte	.LASF24
	.byte	0x5
	.uleb128 0
	.4byte	.LASF25
	.byte	0x5
	.uleb128 0
	.4byte	.LASF26
	.byte	0x5
	.uleb128 0
	.4byte	.LASF27
	.byte	0x5
	.uleb128 0
	.4byte	.LASF28
	.byte	0x5
	.uleb128 0
	.4byte	.LASF29
	.byte	0x5
	.uleb128 0
	.4byte	.LASF30
	.byte	0x5
	.uleb128 0
	.4byte	.LASF31
	.byte	0x5
	.uleb128 0
	.4byte	.LASF32
	.byte	0x5
	.uleb128 0
	.4byte	.LASF33
	.byte	0x5
	.uleb128 0
	.4byte	.LASF34
	.byte	0x5
	.uleb128 0
	.4byte	.LASF35
	.byte	0x5
	.uleb128 0
	.4byte	.LASF36
	.byte	0x5
	.uleb128 0
	.4byte	.LASF37
	.byte	0x5
	.uleb128 0
	.4byte	.LASF38
	.byte	0x5
	.uleb128 0
	.4byte	.LASF39
	.byte	0x5
	.uleb128 0
	.4byte	.LASF40
	.byte	0x5
	.uleb128 0
	.4byte	.LASF41
	.byte	0x5
	.uleb128 0
	.4byte	.LASF42
	.byte	0x5
	.uleb128 0
	.4byte	.LASF43
	.byte	0x5
	.uleb128 0
	.4byte	.LASF44
	.byte	0x5
	.uleb128 0
	.4byte	.LASF45
	.byte	0x5
	.uleb128 0
	.4byte	.LASF46
	.byte	0x5
	.uleb128 0
	.4byte	.LASF47
	.byte	0x5
	.uleb128 0
	.4byte	.LASF48
	.byte	0x5
	.uleb128 0
	.4byte	.LASF49
	.byte	0x5
	.uleb128 0
	.4byte	.LASF50
	.byte	0x5
	.uleb128 0
	.4byte	.LASF51
	.byte	0x5
	.uleb128 0
	.4byte	.LASF52
	.byte	0x5
	.uleb128 0
	.4byte	.LASF53
	.byte	0x5
	.uleb128 0
	.4byte	.LASF54
	.byte	0x5
	.uleb128 0
	.4byte	.LASF55
	.byte	0x5
	.uleb128 0
	.4byte	.LASF56
	.byte	0x5
	.uleb128 0
	.4byte	.LASF57
	.byte	0x5
	.uleb128 0
	.4byte	.LASF58
	.byte	0x5
	.uleb128 0
	.4byte	.LASF59
	.byte	0x5
	.uleb128 0
	.4byte	.LASF60
	.byte	0x5
	.uleb128 0
	.4byte	.LASF61
	.byte	0x5
	.uleb128 0
	.4byte	.LASF62
	.byte	0x5
	.uleb128 0
	.4byte	.LASF63
	.byte	0x5
	.uleb128 0
	.4byte	.LASF64
	.byte	0x5
	.uleb128 0
	.4byte	.LASF65
	.byte	0x5
	.uleb128 0
	.4byte	.LASF66
	.byte	0x5
	.uleb128 0
	.4byte	.LASF67
	.byte	0x5
	.uleb128 0
	.4byte	.LASF68
	.byte	0x5
	.uleb128 0
	.4byte	.LASF69
	.byte	0x5
	.uleb128 0
	.4byte	.LASF70
	.byte	0x5
	.uleb128 0
	.4byte	.LASF71
	.byte	0x5
	.uleb128 0
	.4byte	.LASF72
	.byte	0x5
	.uleb128 0
	.4byte	.LASF73
	.byte	0x5
	.uleb128 0
	.4byte	.LASF74
	.byte	0x5
	.uleb128 0
	.4byte	.LASF75
	.byte	0x5
	.uleb128 0
	.4byte	.LASF76
	.byte	0x5
	.uleb128 0
	.4byte	.LASF77
	.byte	0x5
	.uleb128 0
	.4byte	.LASF78
	.byte	0x5
	.uleb128 0
	.4byte	.LASF79
	.byte	0x5
	.uleb128 0
	.4byte	.LASF80
	.byte	0x5
	.uleb128 0
	.4byte	.LASF81
	.byte	0x5
	.uleb128 0
	.4byte	.LASF82
	.byte	0x5
	.uleb128 0
	.4byte	.LASF83
	.byte	0x5
	.uleb128 0
	.4byte	.LASF84
	.byte	0x5
	.uleb128 0
	.4byte	.LASF85
	.byte	0x5
	.uleb128 0
	.4byte	.LASF86
	.byte	0x5
	.uleb128 0
	.4byte	.LASF87
	.byte	0x5
	.uleb128 0
	.4byte	.LASF88
	.byte	0x5
	.uleb128 0
	.4byte	.LASF89
	.byte	0x5
	.uleb128 0
	.4byte	.LASF90
	.byte	0x5
	.uleb128 0
	.4byte	.LASF91
	.byte	0x5
	.uleb128 0
	.4byte	.LASF92
	.byte	0x5
	.uleb128 0
	.4byte	.LASF93
	.byte	0x5
	.uleb128 0
	.4byte	.LASF94
	.byte	0x5
	.uleb128 0
	.4byte	.LASF95
	.byte	0x5
	.uleb128 0
	.4byte	.LASF96
	.byte	0x5
	.uleb128 0
	.4byte	.LASF97
	.byte	0x5
	.uleb128 0
	.4byte	.LASF98
	.byte	0x5
	.uleb128 0
	.4byte	.LASF99
	.byte	0x5
	.uleb128 0
	.4byte	.LASF100
	.byte	0x5
	.uleb128 0
	.4byte	.LASF101
	.byte	0x5
	.uleb128 0
	.4byte	.LASF102
	.byte	0x5
	.uleb128 0
	.4byte	.LASF103
	.byte	0x5
	.uleb128 0
	.4byte	.LASF104
	.byte	0x5
	.uleb128 0
	.4byte	.LASF105
	.byte	0x5
	.uleb128 0
	.4byte	.LASF106
	.byte	0x5
	.uleb128 0
	.4byte	.LASF107
	.byte	0x5
	.uleb128 0
	.4byte	.LASF108
	.byte	0x5
	.uleb128 0
	.4byte	.LASF109
	.byte	0x5
	.uleb128 0
	.4byte	.LASF110
	.byte	0x5
	.uleb128 0
	.4byte	.LASF111
	.byte	0x5
	.uleb128 0
	.4byte	.LASF112
	.byte	0x5
	.uleb128 0
	.4byte	.LASF113
	.byte	0x5
	.uleb128 0
	.4byte	.LASF114
	.byte	0x5
	.uleb128 0
	.4byte	.LASF115
	.byte	0x5
	.uleb128 0
	.4byte	.LASF116
	.byte	0x5
	.uleb128 0
	.4byte	.LASF117
	.byte	0x5
	.uleb128 0
	.4byte	.LASF118
	.byte	0x5
	.uleb128 0
	.4byte	.LASF119
	.byte	0x5
	.uleb128 0
	.4byte	.LASF120
	.byte	0x5
	.uleb128 0
	.4byte	.LASF121
	.byte	0x5
	.uleb128 0
	.4byte	.LASF122
	.byte	0x5
	.uleb128 0
	.4byte	.LASF123
	.byte	0x5
	.uleb128 0
	.4byte	.LASF124
	.byte	0x5
	.uleb128 0
	.4byte	.LASF125
	.byte	0x5
	.uleb128 0
	.4byte	.LASF126
	.byte	0x5
	.uleb128 0
	.4byte	.LASF127
	.byte	0x5
	.uleb128 0
	.4byte	.LASF128
	.byte	0x5
	.uleb128 0
	.4byte	.LASF129
	.byte	0x5
	.uleb128 0
	.4byte	.LASF130
	.byte	0x5
	.uleb128 0
	.4byte	.LASF131
	.byte	0x5
	.uleb128 0
	.4byte	.LASF132
	.byte	0x5
	.uleb128 0
	.4byte	.LASF133
	.byte	0x5
	.uleb128 0
	.4byte	.LASF134
	.byte	0x5
	.uleb128 0
	.4byte	.LASF135
	.byte	0x5
	.uleb128 0
	.4byte	.LASF136
	.byte	0x5
	.uleb128 0
	.4byte	.LASF137
	.byte	0x5
	.uleb128 0
	.4byte	.LASF138
	.byte	0x5
	.uleb128 0
	.4byte	.LASF139
	.byte	0x5
	.uleb128 0
	.4byte	.LASF140
	.byte	0x5
	.uleb128 0
	.4byte	.LASF141
	.byte	0x5
	.uleb128 0
	.4byte	.LASF142
	.byte	0x5
	.uleb128 0
	.4byte	.LASF143
	.byte	0x5
	.uleb128 0
	.4byte	.LASF144
	.byte	0x5
	.uleb128 0
	.4byte	.LASF145
	.byte	0x5
	.uleb128 0
	.4byte	.LASF146
	.byte	0x5
	.uleb128 0
	.4byte	.LASF147
	.byte	0x5
	.uleb128 0
	.4byte	.LASF148
	.byte	0x5
	.uleb128 0
	.4byte	.LASF149
	.byte	0x5
	.uleb128 0
	.4byte	.LASF150
	.byte	0x5
	.uleb128 0
	.4byte	.LASF151
	.byte	0x5
	.uleb128 0
	.4byte	.LASF152
	.byte	0x5
	.uleb128 0
	.4byte	.LASF153
	.byte	0x5
	.uleb128 0
	.4byte	.LASF154
	.byte	0x5
	.uleb128 0
	.4byte	.LASF155
	.byte	0x5
	.uleb128 0
	.4byte	.LASF156
	.byte	0x5
	.uleb128 0
	.4byte	.LASF157
	.byte	0x5
	.uleb128 0
	.4byte	.LASF158
	.byte	0x5
	.uleb128 0
	.4byte	.LASF159
	.byte	0x5
	.uleb128 0
	.4byte	.LASF160
	.byte	0x5
	.uleb128 0
	.4byte	.LASF161
	.byte	0x5
	.uleb128 0
	.4byte	.LASF162
	.byte	0x5
	.uleb128 0
	.4byte	.LASF163
	.byte	0x5
	.uleb128 0
	.4byte	.LASF164
	.byte	0x5
	.uleb128 0
	.4byte	.LASF165
	.byte	0x5
	.uleb128 0
	.4byte	.LASF166
	.byte	0x5
	.uleb128 0
	.4byte	.LASF167
	.byte	0x5
	.uleb128 0
	.4byte	.LASF168
	.byte	0x5
	.uleb128 0
	.4byte	.LASF169
	.byte	0x5
	.uleb128 0
	.4byte	.LASF170
	.byte	0x5
	.uleb128 0
	.4byte	.LASF171
	.byte	0x5
	.uleb128 0
	.4byte	.LASF172
	.byte	0x5
	.uleb128 0
	.4byte	.LASF173
	.byte	0x5
	.uleb128 0
	.4byte	.LASF174
	.byte	0x5
	.uleb128 0
	.4byte	.LASF175
	.byte	0x5
	.uleb128 0
	.4byte	.LASF176
	.byte	0x5
	.uleb128 0
	.4byte	.LASF177
	.byte	0x5
	.uleb128 0
	.4byte	.LASF178
	.byte	0x5
	.uleb128 0
	.4byte	.LASF179
	.byte	0x5
	.uleb128 0
	.4byte	.LASF180
	.byte	0x5
	.uleb128 0
	.4byte	.LASF181
	.byte	0x5
	.uleb128 0
	.4byte	.LASF182
	.byte	0x5
	.uleb128 0
	.4byte	.LASF183
	.byte	0x5
	.uleb128 0
	.4byte	.LASF184
	.byte	0x5
	.uleb128 0
	.4byte	.LASF185
	.byte	0x5
	.uleb128 0
	.4byte	.LASF186
	.byte	0x5
	.uleb128 0
	.4byte	.LASF187
	.byte	0x5
	.uleb128 0
	.4byte	.LASF188
	.byte	0x5
	.uleb128 0
	.4byte	.LASF189
	.byte	0x5
	.uleb128 0
	.4byte	.LASF190
	.byte	0x5
	.uleb128 0
	.4byte	.LASF191
	.byte	0x5
	.uleb128 0
	.4byte	.LASF192
	.byte	0x5
	.uleb128 0
	.4byte	.LASF193
	.byte	0x5
	.uleb128 0
	.4byte	.LASF194
	.byte	0x5
	.uleb128 0
	.4byte	.LASF195
	.byte	0x5
	.uleb128 0
	.4byte	.LASF196
	.byte	0x5
	.uleb128 0
	.4byte	.LASF197
	.byte	0x5
	.uleb128 0
	.4byte	.LASF198
	.byte	0x5
	.uleb128 0
	.4byte	.LASF199
	.byte	0x5
	.uleb128 0
	.4byte	.LASF200
	.byte	0x5
	.uleb128 0
	.4byte	.LASF201
	.byte	0x5
	.uleb128 0
	.4byte	.LASF202
	.byte	0x5
	.uleb128 0
	.4byte	.LASF203
	.byte	0x5
	.uleb128 0
	.4byte	.LASF204
	.byte	0x5
	.uleb128 0
	.4byte	.LASF205
	.byte	0x5
	.uleb128 0
	.4byte	.LASF206
	.byte	0x5
	.uleb128 0
	.4byte	.LASF207
	.byte	0x5
	.uleb128 0
	.4byte	.LASF208
	.byte	0x5
	.uleb128 0
	.4byte	.LASF209
	.byte	0x5
	.uleb128 0
	.4byte	.LASF210
	.byte	0x5
	.uleb128 0
	.4byte	.LASF211
	.byte	0x5
	.uleb128 0
	.4byte	.LASF212
	.byte	0x5
	.uleb128 0
	.4byte	.LASF213
	.byte	0x5
	.uleb128 0
	.4byte	.LASF214
	.byte	0x5
	.uleb128 0
	.4byte	.LASF215
	.byte	0x5
	.uleb128 0
	.4byte	.LASF216
	.byte	0x5
	.uleb128 0
	.4byte	.LASF217
	.byte	0x5
	.uleb128 0
	.4byte	.LASF218
	.byte	0x5
	.uleb128 0
	.4byte	.LASF219
	.byte	0x5
	.uleb128 0
	.4byte	.LASF220
	.byte	0x5
	.uleb128 0
	.4byte	.LASF221
	.byte	0x5
	.uleb128 0
	.4byte	.LASF222
	.byte	0x5
	.uleb128 0
	.4byte	.LASF223
	.byte	0x5
	.uleb128 0
	.4byte	.LASF224
	.byte	0x5
	.uleb128 0
	.4byte	.LASF225
	.byte	0x5
	.uleb128 0
	.4byte	.LASF226
	.byte	0x5
	.uleb128 0
	.4byte	.LASF227
	.byte	0x5
	.uleb128 0
	.4byte	.LASF228
	.byte	0x5
	.uleb128 0
	.4byte	.LASF229
	.byte	0x5
	.uleb128 0
	.4byte	.LASF230
	.byte	0x5
	.uleb128 0
	.4byte	.LASF231
	.byte	0x5
	.uleb128 0
	.4byte	.LASF232
	.byte	0x5
	.uleb128 0
	.4byte	.LASF233
	.byte	0x5
	.uleb128 0
	.4byte	.LASF234
	.byte	0x5
	.uleb128 0
	.4byte	.LASF235
	.byte	0x5
	.uleb128 0
	.4byte	.LASF236
	.byte	0x5
	.uleb128 0
	.4byte	.LASF237
	.byte	0x5
	.uleb128 0
	.4byte	.LASF238
	.byte	0x5
	.uleb128 0
	.4byte	.LASF239
	.byte	0x5
	.uleb128 0
	.4byte	.LASF240
	.byte	0x5
	.uleb128 0
	.4byte	.LASF241
	.byte	0x5
	.uleb128 0
	.4byte	.LASF242
	.byte	0x5
	.uleb128 0
	.4byte	.LASF243
	.byte	0x5
	.uleb128 0
	.4byte	.LASF244
	.byte	0x5
	.uleb128 0
	.4byte	.LASF245
	.byte	0x5
	.uleb128 0
	.4byte	.LASF246
	.byte	0x5
	.uleb128 0
	.4byte	.LASF247
	.byte	0x5
	.uleb128 0
	.4byte	.LASF248
	.byte	0x5
	.uleb128 0
	.4byte	.LASF249
	.byte	0x5
	.uleb128 0
	.4byte	.LASF250
	.byte	0x5
	.uleb128 0
	.4byte	.LASF251
	.byte	0x5
	.uleb128 0
	.4byte	.LASF252
	.byte	0x5
	.uleb128 0
	.4byte	.LASF253
	.byte	0x5
	.uleb128 0
	.4byte	.LASF254
	.byte	0x5
	.uleb128 0
	.4byte	.LASF255
	.byte	0x5
	.uleb128 0
	.4byte	.LASF256
	.byte	0x5
	.uleb128 0
	.4byte	.LASF257
	.byte	0x5
	.uleb128 0
	.4byte	.LASF258
	.byte	0x5
	.uleb128 0
	.4byte	.LASF259
	.byte	0x5
	.uleb128 0
	.4byte	.LASF260
	.byte	0x5
	.uleb128 0
	.4byte	.LASF261
	.byte	0x5
	.uleb128 0
	.4byte	.LASF262
	.byte	0x5
	.uleb128 0
	.4byte	.LASF263
	.byte	0x5
	.uleb128 0
	.4byte	.LASF264
	.byte	0x5
	.uleb128 0
	.4byte	.LASF265
	.byte	0x5
	.uleb128 0
	.4byte	.LASF266
	.byte	0x5
	.uleb128 0
	.4byte	.LASF267
	.byte	0x5
	.uleb128 0
	.4byte	.LASF268
	.byte	0x5
	.uleb128 0
	.4byte	.LASF269
	.byte	0x5
	.uleb128 0
	.4byte	.LASF270
	.byte	0x5
	.uleb128 0
	.4byte	.LASF271
	.byte	0x5
	.uleb128 0
	.4byte	.LASF272
	.byte	0x5
	.uleb128 0
	.4byte	.LASF273
	.byte	0x5
	.uleb128 0
	.4byte	.LASF274
	.byte	0x5
	.uleb128 0
	.4byte	.LASF275
	.byte	0x5
	.uleb128 0
	.4byte	.LASF276
	.byte	0x5
	.uleb128 0
	.4byte	.LASF277
	.byte	0x5
	.uleb128 0
	.4byte	.LASF278
	.byte	0x5
	.uleb128 0
	.4byte	.LASF279
	.byte	0x5
	.uleb128 0
	.4byte	.LASF280
	.byte	0x5
	.uleb128 0
	.4byte	.LASF281
	.byte	0x5
	.uleb128 0
	.4byte	.LASF282
	.byte	0x5
	.uleb128 0
	.4byte	.LASF283
	.byte	0x5
	.uleb128 0
	.4byte	.LASF284
	.byte	0x5
	.uleb128 0
	.4byte	.LASF285
	.byte	0x5
	.uleb128 0
	.4byte	.LASF286
	.byte	0x5
	.uleb128 0
	.4byte	.LASF287
	.byte	0x5
	.uleb128 0
	.4byte	.LASF288
	.byte	0x5
	.uleb128 0
	.4byte	.LASF289
	.byte	0x5
	.uleb128 0
	.4byte	.LASF290
	.byte	0x5
	.uleb128 0
	.4byte	.LASF291
	.byte	0x5
	.uleb128 0
	.4byte	.LASF292
	.byte	0x5
	.uleb128 0
	.4byte	.LASF293
	.byte	0x5
	.uleb128 0
	.4byte	.LASF294
	.byte	0x5
	.uleb128 0
	.4byte	.LASF295
	.byte	0x5
	.uleb128 0
	.4byte	.LASF296
	.byte	0x5
	.uleb128 0
	.4byte	.LASF297
	.byte	0x5
	.uleb128 0
	.4byte	.LASF298
	.byte	0x5
	.uleb128 0
	.4byte	.LASF299
	.byte	0x5
	.uleb128 0
	.4byte	.LASF300
	.byte	0x5
	.uleb128 0
	.4byte	.LASF301
	.byte	0x5
	.uleb128 0
	.4byte	.LASF302
	.byte	0x5
	.uleb128 0
	.4byte	.LASF303
	.byte	0x5
	.uleb128 0
	.4byte	.LASF304
	.byte	0x5
	.uleb128 0
	.4byte	.LASF305
	.byte	0x5
	.uleb128 0
	.4byte	.LASF306
	.byte	0x5
	.uleb128 0
	.4byte	.LASF307
	.byte	0x5
	.uleb128 0
	.4byte	.LASF308
	.byte	0x5
	.uleb128 0
	.4byte	.LASF309
	.byte	0x5
	.uleb128 0
	.4byte	.LASF310
	.byte	0x5
	.uleb128 0
	.4byte	.LASF311
	.byte	0x5
	.uleb128 0
	.4byte	.LASF312
	.byte	0x5
	.uleb128 0
	.4byte	.LASF313
	.byte	0x5
	.uleb128 0
	.4byte	.LASF314
	.byte	0x5
	.uleb128 0
	.4byte	.LASF315
	.byte	0x5
	.uleb128 0
	.4byte	.LASF316
	.byte	0x5
	.uleb128 0
	.4byte	.LASF317
	.byte	0x5
	.uleb128 0
	.4byte	.LASF318
	.byte	0x5
	.uleb128 0
	.4byte	.LASF319
	.byte	0x5
	.uleb128 0
	.4byte	.LASF320
	.byte	0x5
	.uleb128 0
	.4byte	.LASF321
	.byte	0x5
	.uleb128 0
	.4byte	.LASF322
	.byte	0x5
	.uleb128 0
	.4byte	.LASF323
	.byte	0x5
	.uleb128 0
	.4byte	.LASF324
	.byte	0x5
	.uleb128 0
	.4byte	.LASF325
	.byte	0x5
	.uleb128 0
	.4byte	.LASF326
	.byte	0x5
	.uleb128 0
	.4byte	.LASF327
	.byte	0x5
	.uleb128 0
	.4byte	.LASF328
	.byte	0x5
	.uleb128 0
	.4byte	.LASF329
	.byte	0x5
	.uleb128 0
	.4byte	.LASF330
	.byte	0x5
	.uleb128 0
	.4byte	.LASF331
	.byte	0x5
	.uleb128 0
	.4byte	.LASF332
	.byte	0x5
	.uleb128 0
	.4byte	.LASF333
	.byte	0x5
	.uleb128 0
	.4byte	.LASF334
	.byte	0x5
	.uleb128 0
	.4byte	.LASF335
	.byte	0x5
	.uleb128 0
	.4byte	.LASF336
	.byte	0x5
	.uleb128 0
	.4byte	.LASF337
	.byte	0x5
	.uleb128 0
	.4byte	.LASF338
	.byte	0x5
	.uleb128 0
	.4byte	.LASF339
	.byte	0x5
	.uleb128 0
	.4byte	.LASF340
	.byte	0x5
	.uleb128 0
	.4byte	.LASF341
	.byte	0x5
	.uleb128 0
	.4byte	.LASF342
	.byte	0x5
	.uleb128 0
	.4byte	.LASF343
	.byte	0x5
	.uleb128 0
	.4byte	.LASF344
	.byte	0x5
	.uleb128 0
	.4byte	.LASF345
	.byte	0x5
	.uleb128 0
	.4byte	.LASF346
	.byte	0x5
	.uleb128 0
	.4byte	.LASF347
	.byte	0x5
	.uleb128 0
	.4byte	.LASF348
	.byte	0x5
	.uleb128 0
	.4byte	.LASF349
	.byte	0x5
	.uleb128 0
	.4byte	.LASF350
	.byte	0x5
	.uleb128 0
	.4byte	.LASF351
	.byte	0x5
	.uleb128 0
	.4byte	.LASF352
	.byte	0x5
	.uleb128 0
	.4byte	.LASF353
	.byte	0x5
	.uleb128 0
	.4byte	.LASF354
	.byte	0x5
	.uleb128 0
	.4byte	.LASF355
	.byte	0x5
	.uleb128 0
	.4byte	.LASF356
	.byte	0x5
	.uleb128 0
	.4byte	.LASF357
	.byte	0x5
	.uleb128 0
	.4byte	.LASF358
	.byte	0x5
	.uleb128 0
	.4byte	.LASF359
	.byte	0x5
	.uleb128 0
	.4byte	.LASF360
	.byte	0x5
	.uleb128 0
	.4byte	.LASF361
	.byte	0x5
	.uleb128 0
	.4byte	.LASF362
	.byte	0x5
	.uleb128 0
	.4byte	.LASF363
	.byte	0x5
	.uleb128 0
	.4byte	.LASF364
	.byte	0x5
	.uleb128 0
	.4byte	.LASF365
	.byte	0x5
	.uleb128 0
	.4byte	.LASF366
	.byte	0x5
	.uleb128 0
	.4byte	.LASF367
	.byte	0x5
	.uleb128 0
	.4byte	.LASF368
	.byte	0x5
	.uleb128 0
	.4byte	.LASF369
	.byte	0x5
	.uleb128 0
	.4byte	.LASF370
	.byte	0x5
	.uleb128 0
	.4byte	.LASF371
	.byte	0x5
	.uleb128 0
	.4byte	.LASF372
	.byte	0x5
	.uleb128 0
	.4byte	.LASF373
	.byte	0x5
	.uleb128 0
	.4byte	.LASF374
	.byte	0x5
	.uleb128 0
	.4byte	.LASF375
	.byte	0x5
	.uleb128 0
	.4byte	.LASF376
	.byte	0x5
	.uleb128 0
	.4byte	.LASF377
	.byte	0x5
	.uleb128 0
	.4byte	.LASF378
	.byte	0x5
	.uleb128 0
	.4byte	.LASF379
	.byte	0x5
	.uleb128 0
	.4byte	.LASF380
	.byte	0x5
	.uleb128 0
	.4byte	.LASF381
	.byte	0x5
	.uleb128 0
	.4byte	.LASF382
	.byte	0x5
	.uleb128 0
	.4byte	.LASF383
	.byte	0x5
	.uleb128 0
	.4byte	.LASF384
	.byte	0x5
	.uleb128 0
	.4byte	.LASF385
	.byte	0x5
	.uleb128 0
	.4byte	.LASF386
	.byte	0x5
	.uleb128 0
	.4byte	.LASF387
	.byte	0x5
	.uleb128 0
	.4byte	.LASF388
	.byte	0x5
	.uleb128 0
	.4byte	.LASF389
	.byte	0x5
	.uleb128 0
	.4byte	.LASF390
	.byte	0x5
	.uleb128 0
	.4byte	.LASF391
	.byte	0x5
	.uleb128 0
	.4byte	.LASF392
	.byte	0x5
	.uleb128 0
	.4byte	.LASF393
	.byte	0x5
	.uleb128 0
	.4byte	.LASF394
	.byte	0x5
	.uleb128 0
	.4byte	.LASF395
	.byte	0x5
	.uleb128 0
	.4byte	.LASF396
	.byte	0x5
	.uleb128 0
	.4byte	.LASF397
	.byte	0x6
	.uleb128 0
	.4byte	.LASF398
	.byte	0x5
	.uleb128 0
	.4byte	.LASF399
	.byte	0x6
	.uleb128 0
	.4byte	.LASF400
	.byte	0x6
	.uleb128 0
	.4byte	.LASF401
	.byte	0x6
	.uleb128 0
	.4byte	.LASF402
	.byte	0x6
	.uleb128 0
	.4byte	.LASF403
	.byte	0x5
	.uleb128 0
	.4byte	.LASF404
	.byte	0x6
	.uleb128 0
	.4byte	.LASF405
	.byte	0x6
	.uleb128 0
	.4byte	.LASF406
	.byte	0x5
	.uleb128 0
	.4byte	.LASF407
	.byte	0x5
	.uleb128 0
	.4byte	.LASF408
	.byte	0x6
	.uleb128 0
	.4byte	.LASF409
	.byte	0x5
	.uleb128 0
	.4byte	.LASF410
	.byte	0x5
	.uleb128 0
	.4byte	.LASF411
	.byte	0x5
	.uleb128 0
	.4byte	.LASF412
	.byte	0x6
	.uleb128 0
	.4byte	.LASF413
	.byte	0x5
	.uleb128 0
	.4byte	.LASF414
	.byte	0x5
	.uleb128 0
	.4byte	.LASF415
	.byte	0x6
	.uleb128 0
	.4byte	.LASF416
	.byte	0x5
	.uleb128 0
	.4byte	.LASF417
	.byte	0x5
	.uleb128 0
	.4byte	.LASF418
	.byte	0x5
	.uleb128 0
	.4byte	.LASF419
	.byte	0x5
	.uleb128 0
	.4byte	.LASF420
	.byte	0x5
	.uleb128 0
	.4byte	.LASF421
	.byte	0x6
	.uleb128 0
	.4byte	.LASF422
	.byte	0x5
	.uleb128 0
	.4byte	.LASF423
	.byte	0x5
	.uleb128 0
	.4byte	.LASF424
	.byte	0x5
	.uleb128 0
	.4byte	.LASF425
	.byte	0x6
	.uleb128 0
	.4byte	.LASF426
	.byte	0x5
	.uleb128 0
	.4byte	.LASF427
	.byte	0x6
	.uleb128 0
	.4byte	.LASF428
	.byte	0x6
	.uleb128 0
	.4byte	.LASF429
	.byte	0x6
	.uleb128 0
	.4byte	.LASF430
	.byte	0x6
	.uleb128 0
	.4byte	.LASF431
	.byte	0x6
	.uleb128 0
	.4byte	.LASF432
	.byte	0x6
	.uleb128 0
	.4byte	.LASF433
	.byte	0x5
	.uleb128 0
	.4byte	.LASF434
	.byte	0x6
	.uleb128 0
	.4byte	.LASF435
	.byte	0x6
	.uleb128 0
	.4byte	.LASF436
	.byte	0x6
	.uleb128 0
	.4byte	.LASF437
	.byte	0x5
	.uleb128 0
	.4byte	.LASF438
	.byte	0x5
	.uleb128 0
	.4byte	.LASF439
	.byte	0x5
	.uleb128 0
	.4byte	.LASF440
	.byte	0x5
	.uleb128 0
	.4byte	.LASF441
	.byte	0x5
	.uleb128 0
	.4byte	.LASF442
	.byte	0x5
	.uleb128 0
	.4byte	.LASF443
	.byte	0x5
	.uleb128 0
	.4byte	.LASF444
	.byte	0x6
	.uleb128 0
	.4byte	.LASF445
	.byte	0x5
	.uleb128 0
	.4byte	.LASF446
	.byte	0x5
	.uleb128 0
	.4byte	.LASF447
	.byte	0x5
	.uleb128 0
	.4byte	.LASF448
	.byte	0x5
	.uleb128 0
	.4byte	.LASF449
	.byte	0x5
	.uleb128 0
	.4byte	.LASF439
	.byte	0x5
	.uleb128 0
	.4byte	.LASF450
	.byte	0x5
	.uleb128 0
	.4byte	.LASF451
	.byte	0x5
	.uleb128 0
	.4byte	.LASF452
	.byte	0x5
	.uleb128 0
	.4byte	.LASF453
	.byte	0x5
	.uleb128 0
	.4byte	.LASF454
	.byte	0x5
	.uleb128 0
	.4byte	.LASF455
	.byte	0x5
	.uleb128 0
	.4byte	.LASF456
	.byte	0x5
	.uleb128 0
	.4byte	.LASF457
	.byte	0x5
	.uleb128 0
	.4byte	.LASF458
	.byte	0x5
	.uleb128 0
	.4byte	.LASF459
	.byte	0x5
	.uleb128 0
	.4byte	.LASF460
	.byte	0x5
	.uleb128 0
	.4byte	.LASF461
	.byte	0x5
	.uleb128 0
	.4byte	.LASF462
	.byte	0x5
	.uleb128 0
	.4byte	.LASF463
	.byte	0
	.section	.debug_macro,"G",%progbits,wm4.stdint.h.39.fe42d6eb18d369206696c6985313e641,comdat
.Ldebug_macro3:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF466
	.byte	0x5
	.uleb128 0x79
	.4byte	.LASF467
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF468
	.byte	0x5
	.uleb128 0x7c
	.4byte	.LASF469
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF470
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF471
	.byte	0x5
	.uleb128 0x81
	.4byte	.LASF472
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF473
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF474
	.byte	0x5
	.uleb128 0x85
	.4byte	.LASF475
	.byte	0x5
	.uleb128 0x87
	.4byte	.LASF476
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF477
	.byte	0x5
	.uleb128 0x89
	.4byte	.LASF478
	.byte	0x5
	.uleb128 0x8b
	.4byte	.LASF479
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF480
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF481
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF482
	.byte	0x5
	.uleb128 0x91
	.4byte	.LASF483
	.byte	0x5
	.uleb128 0x92
	.4byte	.LASF484
	.byte	0x5
	.uleb128 0x93
	.4byte	.LASF485
	.byte	0x5
	.uleb128 0x94
	.4byte	.LASF486
	.byte	0x5
	.uleb128 0x95
	.4byte	.LASF487
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF488
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF489
	.byte	0x5
	.uleb128 0x98
	.4byte	.LASF490
	.byte	0x5
	.uleb128 0x99
	.4byte	.LASF491
	.byte	0x5
	.uleb128 0x9a
	.4byte	.LASF492
	.byte	0x5
	.uleb128 0x9b
	.4byte	.LASF493
	.byte	0x5
	.uleb128 0x9d
	.4byte	.LASF494
	.byte	0x5
	.uleb128 0x9e
	.4byte	.LASF495
	.byte	0x5
	.uleb128 0x9f
	.4byte	.LASF496
	.byte	0x5
	.uleb128 0xa0
	.4byte	.LASF497
	.byte	0x5
	.uleb128 0xa1
	.4byte	.LASF498
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF499
	.byte	0x5
	.uleb128 0xa3
	.4byte	.LASF500
	.byte	0x5
	.uleb128 0xa4
	.4byte	.LASF501
	.byte	0x5
	.uleb128 0xa5
	.4byte	.LASF502
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF503
	.byte	0x5
	.uleb128 0xa7
	.4byte	.LASF504
	.byte	0x5
	.uleb128 0xa8
	.4byte	.LASF505
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF506
	.byte	0x5
	.uleb128 0xae
	.4byte	.LASF507
	.byte	0x5
	.uleb128 0xaf
	.4byte	.LASF508
	.byte	0x5
	.uleb128 0xb1
	.4byte	.LASF509
	.byte	0x5
	.uleb128 0xb2
	.4byte	.LASF510
	.byte	0x5
	.uleb128 0xb3
	.4byte	.LASF511
	.byte	0x5
	.uleb128 0xc3
	.4byte	.LASF512
	.byte	0x5
	.uleb128 0xc4
	.4byte	.LASF513
	.byte	0x5
	.uleb128 0xc5
	.4byte	.LASF514
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF515
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF516
	.byte	0x5
	.uleb128 0xc8
	.4byte	.LASF517
	.byte	0x5
	.uleb128 0xc9
	.4byte	.LASF518
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF519
	.byte	0x5
	.uleb128 0xcc
	.4byte	.LASF520
	.byte	0x5
	.uleb128 0xcd
	.4byte	.LASF521
	.byte	0x5
	.uleb128 0xd7
	.4byte	.LASF522
	.byte	0x5
	.uleb128 0xd8
	.4byte	.LASF523
	.byte	0x5
	.uleb128 0xe3
	.4byte	.LASF524
	.byte	0x5
	.uleb128 0xe4
	.4byte	.LASF525
	.byte	0
	.section	.debug_macro,"G",%progbits,wm4.__crossworks.h.39.ff21eb83ebfc80fb95245a821dd1e413,comdat
.Ldebug_macro4:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x27
	.4byte	.LASF527
	.byte	0x5
	.uleb128 0x3b
	.4byte	.LASF528
	.byte	0x6
	.uleb128 0x3d
	.4byte	.LASF529
	.byte	0x5
	.uleb128 0x3f
	.4byte	.LASF530
	.byte	0x5
	.uleb128 0x43
	.4byte	.LASF531
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF532
	.byte	0x5
	.uleb128 0x56
	.4byte	.LASF533
	.byte	0x5
	.uleb128 0x5d
	.4byte	.LASF528
	.byte	0x5
	.uleb128 0x63
	.4byte	.LASF534
	.byte	0x5
	.uleb128 0x64
	.4byte	.LASF535
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF536
	.byte	0x5
	.uleb128 0x66
	.4byte	.LASF537
	.byte	0x5
	.uleb128 0x67
	.4byte	.LASF538
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF539
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF540
	.byte	0x5
	.uleb128 0x6a
	.4byte	.LASF541
	.byte	0x5
	.uleb128 0x6d
	.4byte	.LASF542
	.byte	0x5
	.uleb128 0x6e
	.4byte	.LASF543
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF544
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF545
	.byte	0x5
	.uleb128 0x73
	.4byte	.LASF546
	.byte	0x5
	.uleb128 0xd8
	.4byte	.LASF547
	.byte	0
	.section	.debug_macro,"G",%progbits,wm4.stddef.h.44.3483ea4b5d43bc7237f8a88f13989923,comdat
.Ldebug_macro5:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x2c
	.4byte	.LASF548
	.byte	0x5
	.uleb128 0x40
	.4byte	.LASF549
	.byte	0x5
	.uleb128 0x45
	.4byte	.LASF550
	.byte	0x5
	.uleb128 0x4c
	.4byte	.LASF551
	.byte	0
	.section	.debug_macro,"G",%progbits,wm4.bme680_defs.h.101.713d994dead6d8818e414af2134f1131,comdat
.Ldebug_macro6:
	.2byte	0x4
	.byte	0
	.byte	0x5
	.uleb128 0x65
	.4byte	.LASF552
	.byte	0x5
	.uleb128 0x68
	.4byte	.LASF553
	.byte	0x5
	.uleb128 0x69
	.4byte	.LASF554
	.byte	0x5
	.uleb128 0x6c
	.4byte	.LASF555
	.byte	0x5
	.uleb128 0x6f
	.4byte	.LASF556
	.byte	0x5
	.uleb128 0x70
	.4byte	.LASF557
	.byte	0x5
	.uleb128 0x71
	.4byte	.LASF558
	.byte	0x5
	.uleb128 0x74
	.4byte	.LASF559
	.byte	0x5
	.uleb128 0x75
	.4byte	.LASF560
	.byte	0x5
	.uleb128 0x78
	.4byte	.LASF561
	.byte	0x5
	.uleb128 0x7b
	.4byte	.LASF562
	.byte	0x5
	.uleb128 0x7d
	.4byte	.LASF563
	.byte	0x5
	.uleb128 0x7e
	.4byte	.LASF564
	.byte	0x5
	.uleb128 0x7f
	.4byte	.LASF565
	.byte	0x5
	.uleb128 0x80
	.4byte	.LASF566
	.byte	0x5
	.uleb128 0x83
	.4byte	.LASF567
	.byte	0x5
	.uleb128 0x84
	.4byte	.LASF568
	.byte	0x5
	.uleb128 0x87
	.4byte	.LASF569
	.byte	0x5
	.uleb128 0x88
	.4byte	.LASF570
	.byte	0x5
	.uleb128 0x8c
	.4byte	.LASF571
	.byte	0x5
	.uleb128 0x8d
	.4byte	.LASF572
	.byte	0x5
	.uleb128 0x8e
	.4byte	.LASF573
	.byte	0x5
	.uleb128 0x8f
	.4byte	.LASF574
	.byte	0x5
	.uleb128 0x90
	.4byte	.LASF575
	.byte	0x5
	.uleb128 0x93
	.4byte	.LASF576
	.byte	0x5
	.uleb128 0x96
	.4byte	.LASF577
	.byte	0x5
	.uleb128 0x97
	.4byte	.LASF578
	.byte	0x5
	.uleb128 0x9a
	.4byte	.LASF579
	.byte	0x5
	.uleb128 0x9b
	.4byte	.LASF580
	.byte	0x5
	.uleb128 0x9c
	.4byte	.LASF581
	.byte	0x5
	.uleb128 0x9d
	.4byte	.LASF582
	.byte	0x5
	.uleb128 0x9e
	.4byte	.LASF583
	.byte	0x5
	.uleb128 0x9f
	.4byte	.LASF584
	.byte	0x5
	.uleb128 0xa2
	.4byte	.LASF585
	.byte	0x5
	.uleb128 0xa3
	.4byte	.LASF586
	.byte	0x5
	.uleb128 0xa6
	.4byte	.LASF587
	.byte	0x5
	.uleb128 0xa9
	.4byte	.LASF588
	.byte	0x5
	.uleb128 0xac
	.4byte	.LASF589
	.byte	0x5
	.uleb128 0xad
	.4byte	.LASF590
	.byte	0x5
	.uleb128 0xb0
	.4byte	.LASF591
	.byte	0x5
	.uleb128 0xb1
	.4byte	.LASF592
	.byte	0x5
	.uleb128 0xb4
	.4byte	.LASF593
	.byte	0x5
	.uleb128 0xb5
	.4byte	.LASF594
	.byte	0x5
	.uleb128 0xb6
	.4byte	.LASF595
	.byte	0x5
	.uleb128 0xb7
	.4byte	.LASF596
	.byte	0x5
	.uleb128 0xb8
	.4byte	.LASF597
	.byte	0x5
	.uleb128 0xb9
	.4byte	.LASF598
	.byte	0x5
	.uleb128 0xbc
	.4byte	.LASF599
	.byte	0x5
	.uleb128 0xbd
	.4byte	.LASF600
	.byte	0x5
	.uleb128 0xbe
	.4byte	.LASF601
	.byte	0x5
	.uleb128 0xbf
	.4byte	.LASF602
	.byte	0x5
	.uleb128 0xc0
	.4byte	.LASF603
	.byte	0x5
	.uleb128 0xc1
	.4byte	.LASF604
	.byte	0x5
	.uleb128 0xc2
	.4byte	.LASF605
	.byte	0x5
	.uleb128 0xc3
	.4byte	.LASF606
	.byte	0x5
	.uleb128 0xc6
	.4byte	.LASF607
	.byte	0x5
	.uleb128 0xc7
	.4byte	.LASF608
	.byte	0x5
	.uleb128 0xca
	.4byte	.LASF609
	.byte	0x5
	.uleb128 0xcd
	.4byte	.LASF610
	.byte	0x5
	.uleb128 0xce
	.4byte	.LASF611
	.byte	0x5
	.uleb128 0xd1
	.4byte	.LASF612
	.byte	0x5
	.uleb128 0xd4
	.4byte	.LASF613
	.byte	0x5
	.uleb128 0xd5
	.4byte	.LASF614
	.byte	0x5
	.uleb128 0xd8
	.4byte	.LASF615
	.byte	0x5
	.uleb128 0xd9
	.4byte	.LASF616
	.byte	0x5
	.uleb128 0xda
	.4byte	.LASF617
	.byte	0x5
	.uleb128 0xdb
	.4byte	.LASF618
	.byte	0x5
	.uleb128 0xde
	.4byte	.LASF619
	.byte	0x5
	.uleb128 0xdf
	.4byte	.LASF620
	.byte	0x5
	.uleb128 0xe0
	.4byte	.LASF621
	.byte	0x5
	.uleb128 0xe1
	.4byte	.LASF622
	.byte	0x5
	.uleb128 0xe2
	.4byte	.LASF623
	.byte	0x5
	.uleb128 0xe3
	.4byte	.LASF624
	.byte	0x5
	.uleb128 0xe4
	.4byte	.LASF625
	.byte	0x5
	.uleb128 0xe5
	.4byte	.LASF626
	.byte	0x5
	.uleb128 0xe6
	.4byte	.LASF627
	.byte	0x5
	.uleb128 0xe9
	.4byte	.LASF628
	.byte	0x5
	.uleb128 0xea
	.4byte	.LASF629
	.byte	0x5
	.uleb128 0xed
	.4byte	.LASF630
	.byte	0x5
	.uleb128 0xee
	.4byte	.LASF631
	.byte	0x5
	.uleb128 0xef
	.4byte	.LASF632
	.byte	0x5
	.uleb128 0xf0
	.4byte	.LASF633
	.byte	0x5
	.uleb128 0xf1
	.4byte	.LASF634
	.byte	0x5
	.uleb128 0xf2
	.4byte	.LASF635
	.byte	0x5
	.uleb128 0xf3
	.4byte	.LASF636
	.byte	0x5
	.uleb128 0xf4
	.4byte	.LASF637
	.byte	0x5
	.uleb128 0xf5
	.4byte	.LASF638
	.byte	0x5
	.uleb128 0xf6
	.4byte	.LASF639
	.byte	0x5
	.uleb128 0xf7
	.4byte	.LASF640
	.byte	0x5
	.uleb128 0xf8
	.4byte	.LASF641
	.byte	0x5
	.uleb128 0xf9
	.4byte	.LASF642
	.byte	0x5
	.uleb128 0xfa
	.4byte	.LASF643
	.byte	0x5
	.uleb128 0xfb
	.4byte	.LASF644
	.byte	0x5
	.uleb128 0xfc
	.4byte	.LASF645
	.byte	0x5
	.uleb128 0xfd
	.4byte	.LASF646
	.byte	0x5
	.uleb128 0xfe
	.4byte	.LASF647
	.byte	0x5
	.uleb128 0xff
	.4byte	.LASF648
	.byte	0x5
	.uleb128 0x100
	.4byte	.LASF649
	.byte	0x5
	.uleb128 0x103
	.4byte	.LASF650
	.byte	0x5
	.uleb128 0x104
	.4byte	.LASF651
	.byte	0x5
	.uleb128 0x105
	.4byte	.LASF652
	.byte	0x5
	.uleb128 0x106
	.4byte	.LASF653
	.byte	0x5
	.uleb128 0x107
	.4byte	.LASF654
	.byte	0x5
	.uleb128 0x10a
	.4byte	.LASF655
	.byte	0x5
	.uleb128 0x10b
	.4byte	.LASF656
	.byte	0x5
	.uleb128 0x10c
	.4byte	.LASF657
	.byte	0x5
	.uleb128 0x10d
	.4byte	.LASF658
	.byte	0x5
	.uleb128 0x10e
	.4byte	.LASF659
	.byte	0x5
	.uleb128 0x10f
	.4byte	.LASF660
	.byte	0x5
	.uleb128 0x110
	.4byte	.LASF661
	.byte	0x5
	.uleb128 0x111
	.4byte	.LASF662
	.byte	0x5
	.uleb128 0x112
	.4byte	.LASF663
	.byte	0x5
	.uleb128 0x113
	.4byte	.LASF664
	.byte	0x5
	.uleb128 0x114
	.4byte	.LASF665
	.byte	0x5
	.uleb128 0x115
	.4byte	.LASF666
	.byte	0x5
	.uleb128 0x116
	.4byte	.LASF667
	.byte	0x5
	.uleb128 0x117
	.4byte	.LASF668
	.byte	0x5
	.uleb128 0x118
	.4byte	.LASF669
	.byte	0x5
	.uleb128 0x119
	.4byte	.LASF670
	.byte	0x5
	.uleb128 0x11a
	.4byte	.LASF671
	.byte	0x5
	.uleb128 0x11b
	.4byte	.LASF672
	.byte	0x5
	.uleb128 0x11c
	.4byte	.LASF673
	.byte	0x5
	.uleb128 0x11d
	.4byte	.LASF674
	.byte	0x5
	.uleb128 0x11e
	.4byte	.LASF675
	.byte	0x5
	.uleb128 0x11f
	.4byte	.LASF676
	.byte	0x5
	.uleb128 0x120
	.4byte	.LASF677
	.byte	0x5
	.uleb128 0x121
	.4byte	.LASF678
	.byte	0x5
	.uleb128 0x122
	.4byte	.LASF679
	.byte	0x5
	.uleb128 0x123
	.4byte	.LASF680
	.byte	0x5
	.uleb128 0x124
	.4byte	.LASF681
	.byte	0x5
	.uleb128 0x125
	.4byte	.LASF682
	.byte	0x5
	.uleb128 0x126
	.4byte	.LASF683
	.byte	0x5
	.uleb128 0x127
	.4byte	.LASF684
	.byte	0x5
	.uleb128 0x128
	.4byte	.LASF685
	.byte	0x5
	.uleb128 0x129
	.4byte	.LASF686
	.byte	0x5
	.uleb128 0x12a
	.4byte	.LASF687
	.byte	0x5
	.uleb128 0x12b
	.4byte	.LASF688
	.byte	0x5
	.uleb128 0x12e
	.4byte	.LASF689
	.byte	0x5
	.uleb128 0x12f
	.4byte	.LASF690
	.byte	0x5
	.uleb128 0x130
	.4byte	.LASF691
	.byte	0x5
	.uleb128 0x131
	.4byte	.LASF692
	.byte	0x5
	.uleb128 0x132
	.4byte	.LASF693
	.byte	0x5
	.uleb128 0x133
	.4byte	.LASF694
	.byte	0x5
	.uleb128 0x134
	.4byte	.LASF695
	.byte	0x5
	.uleb128 0x13c
	.4byte	.LASF696
	.byte	0x5
	.uleb128 0x13f
	.4byte	.LASF697
	.byte	0x5
	.uleb128 0x142
	.4byte	.LASF698
	.byte	0x5
	.uleb128 0x145
	.4byte	.LASF699
	.byte	0x5
	.uleb128 0x149
	.4byte	.LASF700
	.byte	0x5
	.uleb128 0x14c
	.4byte	.LASF701
	.byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF234:
	.ascii	"__DEC32_MANT_DIG__ 7\000"
.LASF182:
	.ascii	"__DECIMAL_DIG__ 17\000"
.LASF363:
	.ascii	"__UHA_FBIT__ 8\000"
.LASF702:
	.ascii	"int8_t\000"
.LASF616:
	.ascii	"BME680_REG_BUFFER_LENGTH UINT8_C(6)\000"
.LASF253:
	.ascii	"__DEC128_EPSILON__ 1E-33DL\000"
.LASF76:
	.ascii	"__WCHAR_MIN__ 0U\000"
.LASF578:
	.ascii	"BME680_GAS_WAIT0_ADDR UINT8_C(0x64)\000"
.LASF383:
	.ascii	"__GCC_ATOMIC_WCHAR_T_LOCK_FREE 2\000"
.LASF375:
	.ascii	"__CHAR_UNSIGNED__ 1\000"
.LASF688:
	.ascii	"BME680_GH3_REG (38)\000"
.LASF255:
	.ascii	"__SFRACT_FBIT__ 7\000"
.LASF768:
	.ascii	"__locale_s\000"
.LASF218:
	.ascii	"__FLT64_HAS_INFINITY__ 1\000"
.LASF528:
	.ascii	"__THREAD __thread\000"
.LASF327:
	.ascii	"__LLACCUM_MIN__ (-0X1P31LLK-0X1P31LLK)\000"
.LASF319:
	.ascii	"__LACCUM_EPSILON__ 0x1P-31LK\000"
.LASF79:
	.ascii	"__PTRDIFF_MAX__ 0x7fffffff\000"
.LASF762:
	.ascii	"__RAL_locale_codeset_t\000"
.LASF621:
	.ascii	"BME680_OSH_SEL UINT16_C(4)\000"
.LASF91:
	.ascii	"__INTMAX_C(c) c ## LL\000"
.LASF214:
	.ascii	"__FLT64_MIN__ 1.1\000"
.LASF90:
	.ascii	"__INTMAX_MAX__ 0x7fffffffffffffffLL\000"
.LASF240:
	.ascii	"__DEC32_SUBNORMAL_MIN__ 0.000001E-95DF\000"
.LASF344:
	.ascii	"__TQ_IBIT__ 0\000"
.LASF531:
	.ascii	"__RAL_SIZE_MAX 4294967295UL\000"
.LASF222:
	.ascii	"__FLT32X_MIN_EXP__ (-1021)\000"
.LASF913:
	.ascii	"tph_dur\000"
.LASF116:
	.ascii	"__INT64_C(c) c ## LL\000"
.LASF14:
	.ascii	"__ATOMIC_CONSUME 1\000"
.LASF277:
	.ascii	"__LFRACT_MIN__ (-0.5LR-0.5LR)\000"
.LASF75:
	.ascii	"__WCHAR_MAX__ 0xffffffffU\000"
.LASF788:
	.ascii	"__RAL_error_decoder_s\000"
.LASF791:
	.ascii	"__RAL_error_decoder_t\000"
.LASF875:
	.ascii	"tries\000"
.LASF710:
	.ascii	"int32_t\000"
.LASF18:
	.ascii	"__SIZEOF_LONG_LONG__ 8\000"
.LASF167:
	.ascii	"__DBL_MAX_10_EXP__ 308\000"
.LASF695:
	.ascii	"BME680_REG_HCTRL_INDEX UINT8_C(0)\000"
.LASF206:
	.ascii	"__FLT64_MANT_DIG__ 53\000"
.LASF267:
	.ascii	"__FRACT_MIN__ (-0.5R-0.5R)\000"
.LASF333:
	.ascii	"__ULLACCUM_MAX__ 0XFFFFFFFFFFFFFFFFP-32ULLK\000"
.LASF500:
	.ascii	"INT_FAST32_MAX INT32_MAX\000"
.LASF303:
	.ascii	"__USACCUM_MAX__ 0XFFFFP-8UHK\000"
.LASF237:
	.ascii	"__DEC32_MIN__ 1E-95DF\000"
.LASF94:
	.ascii	"__INTMAX_WIDTH__ 64\000"
.LASF630:
	.ascii	"BME680_GAS_MEAS_MSK UINT8_C(0x30)\000"
.LASF340:
	.ascii	"__SQ_IBIT__ 0\000"
.LASF28:
	.ascii	"__ORDER_PDP_ENDIAN__ 3412\000"
.LASF32:
	.ascii	"__SIZE_TYPE__ unsigned int\000"
.LASF243:
	.ascii	"__DEC64_MAX_EXP__ 385\000"
.LASF158:
	.ascii	"__FLT_HAS_DENORM__ 1\000"
.LASF706:
	.ascii	"int16_t\000"
.LASF414:
	.ascii	"__ARM_ARCH_PROFILE 77\000"
.LASF904:
	.ascii	"get_gas_config\000"
.LASF302:
	.ascii	"__USACCUM_MIN__ 0.0UHK\000"
.LASF454:
	.ascii	"__GNU_LINKER 1\000"
.LASF596:
	.ascii	"BME680_OS_4X UINT8_C(3)\000"
.LASF178:
	.ascii	"__LDBL_MIN_EXP__ (-1021)\000"
.LASF176:
	.ascii	"__LDBL_MANT_DIG__ 53\000"
.LASF822:
	.ascii	"par_p3\000"
.LASF834:
	.ascii	"bme680_tph_sett\000"
.LASF858:
	.ascii	"write\000"
.LASF119:
	.ascii	"__UINT8_C(c) c\000"
.LASF42:
	.ascii	"__INT16_TYPE__ short int\000"
.LASF751:
	.ascii	"time_format\000"
.LASF507:
	.ascii	"PTRDIFF_MAX INT32_MAX\000"
.LASF530:
	.ascii	"__RAL_SIZE_T unsigned\000"
.LASF779:
	.ascii	"__RAL_data_utf8_period\000"
.LASF479:
	.ascii	"INTMAX_MIN (-9223372036854775807LL-1)\000"
.LASF323:
	.ascii	"__ULACCUM_MAX__ 0XFFFFFFFFFFFFFFFFP-32ULK\000"
.LASF513:
	.ascii	"UINT8_C(x) (x ##U)\000"
.LASF811:
	.ascii	"par_h5\000"
.LASF549:
	.ascii	"NULL 0\000"
.LASF376:
	.ascii	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1\000"
.LASF925:
	.ascii	"desired_settings\000"
.LASF844:
	.ascii	"heatr_dur\000"
.LASF69:
	.ascii	"__GXX_ABI_VERSION 1013\000"
.LASF4:
	.ascii	"__STDC_HOSTED__ 1\000"
.LASF290:
	.ascii	"__ULLFRACT_FBIT__ 64\000"
.LASF652:
	.ascii	"BME680_OST_POS UINT8_C(5)\000"
.LASF40:
	.ascii	"__SIG_ATOMIC_TYPE__ int\000"
.LASF612:
	.ascii	"BME680_HUM_REG_SHIFT_VAL UINT8_C(4)\000"
.LASF510:
	.ascii	"INTPTR_MAX INT32_MAX\000"
.LASF60:
	.ascii	"__INT_FAST64_TYPE__ long long int\000"
.LASF35:
	.ascii	"__WINT_TYPE__ unsigned int\000"
.LASF724:
	.ascii	"int_curr_symbol\000"
.LASF196:
	.ascii	"__FLT32_MAX_10_EXP__ 38\000"
.LASF46:
	.ascii	"__UINT16_TYPE__ short unsigned int\000"
.LASF929:
	.ascii	"reg_array\000"
.LASF534:
	.ascii	"__CTYPE_UPPER 0x01\000"
.LASF263:
	.ascii	"__USFRACT_MAX__ 0XFFP-8UHR\000"
.LASF205:
	.ascii	"__FP_FAST_FMAF32 1\000"
.LASF634:
	.ascii	"BME680_OSP_MSK UINT8_C(0X1C)\000"
.LASF140:
	.ascii	"__UINTPTR_MAX__ 0xffffffffU\000"
.LASF846:
	.ascii	"chip_id\000"
.LASF569:
	.ascii	"BME680_I_MIN_CORRECTION UINT8_C(1)\000"
.LASF193:
	.ascii	"__FLT32_MIN_EXP__ (-125)\000"
.LASF102:
	.ascii	"__UINT8_MAX__ 0xff\000"
.LASF889:
	.ascii	"gas_res_adc\000"
.LASF735:
	.ascii	"n_cs_precedes\000"
.LASF543:
	.ascii	"__CTYPE_ALNUM (__CTYPE_UPPER | __CTYPE_LOWER | __CT"
	.ascii	"YPE_DIGIT)\000"
.LASF807:
	.ascii	"par_h1\000"
.LASF467:
	.ascii	"UINT8_MAX 255\000"
.LASF809:
	.ascii	"par_h3\000"
.LASF810:
	.ascii	"par_h4\000"
.LASF756:
	.ascii	"__tolower\000"
.LASF812:
	.ascii	"par_h6\000"
.LASF813:
	.ascii	"par_h7\000"
.LASF209:
	.ascii	"__FLT64_MIN_10_EXP__ (-307)\000"
.LASF355:
	.ascii	"__HA_FBIT__ 7\000"
.LASF469:
	.ascii	"INT8_MIN (-128)\000"
.LASF133:
	.ascii	"__INT_FAST64_WIDTH__ 64\000"
.LASF1:
	.ascii	"__STDC_VERSION__ 199901L\000"
.LASF611:
	.ascii	"BME680_MEM_PAGE1 UINT8_C(0x00)\000"
.LASF310:
	.ascii	"__UACCUM_FBIT__ 16\000"
.LASF259:
	.ascii	"__SFRACT_EPSILON__ 0x1P-7HR\000"
.LASF2:
	.ascii	"__STDC_UTF_16__ 1\000"
.LASF165:
	.ascii	"__DBL_MIN_10_EXP__ (-307)\000"
.LASF932:
	.ascii	"soft_rst_cmd\000"
.LASF731:
	.ascii	"int_frac_digits\000"
.LASF745:
	.ascii	"day_names\000"
.LASF339:
	.ascii	"__SQ_FBIT__ 31\000"
.LASF567:
	.ascii	"BME680_W_DEFINE_PWR_MODE INT8_C(1)\000"
.LASF504:
	.ascii	"UINT_FAST32_MAX UINT32_MAX\000"
.LASF557:
	.ascii	"BME680_COEFF_ADDR1_LEN UINT8_C(25)\000"
.LASF891:
	.ascii	"lookupTable1\000"
.LASF833:
	.ascii	"range_sw_err\000"
.LASF347:
	.ascii	"__UHQ_FBIT__ 16\000"
.LASF208:
	.ascii	"__FLT64_MIN_EXP__ (-1021)\000"
.LASF457:
	.ascii	"BOARD_PCA10056 1\000"
.LASF88:
	.ascii	"__PTRDIFF_WIDTH__ 32\000"
.LASF229:
	.ascii	"__FLT32X_EPSILON__ 1.1\000"
.LASF134:
	.ascii	"__UINT_FAST8_MAX__ 0xffffffffU\000"
.LASF618:
	.ascii	"BME680_GAS_REG_BUF_LENGTH UINT8_C(20)\000"
.LASF239:
	.ascii	"__DEC32_EPSILON__ 1E-6DF\000"
.LASF455:
	.ascii	"DEBUG 1\000"
.LASF154:
	.ascii	"__FLT_MAX__ 1.1\000"
.LASF316:
	.ascii	"__LACCUM_IBIT__ 32\000"
.LASF901:
	.ascii	"calc_temperature\000"
.LASF129:
	.ascii	"__INT_FAST16_WIDTH__ 32\000"
.LASF848:
	.ascii	"intf\000"
.LASF425:
	.ascii	"__VFP_FP__ 1\000"
.LASF287:
	.ascii	"__LLFRACT_MIN__ (-0.5LLR-0.5LLR)\000"
.LASF138:
	.ascii	"__INTPTR_MAX__ 0x7fffffff\000"
.LASF389:
	.ascii	"__GCC_ATOMIC_POINTER_LOCK_FREE 2\000"
.LASF135:
	.ascii	"__UINT_FAST16_MAX__ 0xffffffffU\000"
.LASF839:
	.ascii	"bme680_gas_sett\000"
.LASF553:
	.ascii	"BME680_I2C_ADDR_PRIMARY UINT8_C(0x76)\000"
.LASF934:
	.ascii	"tmp_buff\000"
.LASF200:
	.ascii	"__FLT32_EPSILON__ 1.1\000"
.LASF238:
	.ascii	"__DEC32_MAX__ 9.999999E96DF\000"
.LASF272:
	.ascii	"__UFRACT_MIN__ 0.0UR\000"
.LASF472:
	.ascii	"INT16_MAX 32767\000"
.LASF519:
	.ascii	"UINT64_C(x) (x ##ULL)\000"
.LASF96:
	.ascii	"__SIG_ATOMIC_MIN__ (-__SIG_ATOMIC_MAX__ - 1)\000"
.LASF232:
	.ascii	"__FLT32X_HAS_INFINITY__ 1\000"
.LASF900:
	.ascii	"pressure_comp\000"
.LASF910:
	.ascii	"coeff_array\000"
.LASF620:
	.ascii	"BME680_OSP_SEL UINT16_C(2)\000"
.LASF53:
	.ascii	"__UINT_LEAST8_TYPE__ unsigned char\000"
.LASF726:
	.ascii	"mon_decimal_point\000"
.LASF305:
	.ascii	"__ACCUM_FBIT__ 15\000"
.LASF311:
	.ascii	"__UACCUM_IBIT__ 16\000"
.LASF719:
	.ascii	"long int\000"
.LASF849:
	.ascii	"mem_page\000"
.LASF228:
	.ascii	"__FLT32X_MIN__ 1.1\000"
.LASF132:
	.ascii	"__INT_FAST64_MAX__ 0x7fffffffffffffffLL\000"
.LASF226:
	.ascii	"__FLT32X_DECIMAL_DIG__ 17\000"
.LASF533:
	.ascii	"__CODE \000"
.LASF233:
	.ascii	"__FLT32X_HAS_QUIET_NAN__ 1\000"
.LASF876:
	.ascii	"calc_heater_dur\000"
.LASF249:
	.ascii	"__DEC128_MIN_EXP__ (-6142)\000"
.LASF57:
	.ascii	"__INT_FAST8_TYPE__ int\000"
.LASF367:
	.ascii	"__UDA_FBIT__ 32\000"
.LASF668:
	.ascii	"BME680_P6_REG (16)\000"
.LASF770:
	.ascii	"__RAL_global_locale\000"
.LASF93:
	.ascii	"__UINTMAX_C(c) c ## ULL\000"
.LASF572:
	.ascii	"BME680_ADDR_RES_HEAT_RANGE_ADDR UINT8_C(0x02)\000"
.LASF31:
	.ascii	"__SIZEOF_POINTER__ 4\000"
.LASF49:
	.ascii	"__INT_LEAST8_TYPE__ signed char\000"
.LASF604:
	.ascii	"BME680_FILTER_SIZE_31 UINT8_C(5)\000"
.LASF787:
	.ascii	"__RAL_error_decoder_fn_t\000"
.LASF690:
	.ascii	"BME680_REG_TEMP_INDEX UINT8_C(4)\000"
.LASF435:
	.ascii	"__ARM_NEON__\000"
.LASF195:
	.ascii	"__FLT32_MAX_EXP__ 128\000"
.LASF438:
	.ascii	"__THUMB_INTERWORK__ 1\000"
.LASF293:
	.ascii	"__ULLFRACT_MAX__ 0XFFFFFFFFFFFFFFFFP-64ULLR\000"
.LASF212:
	.ascii	"__FLT64_DECIMAL_DIG__ 17\000"
.LASF648:
	.ascii	"BME680_SPI_WR_MSK UINT8_C(0x7f)\000"
.LASF223:
	.ascii	"__FLT32X_MIN_10_EXP__ (-307)\000"
.LASF39:
	.ascii	"__CHAR32_TYPE__ long unsigned int\000"
.LASF432:
	.ascii	"__ARM_FEATURE_FP16_VECTOR_ARITHMETIC\000"
.LASF478:
	.ascii	"UINT64_MAX 18446744073709551615ULL\000"
.LASF136:
	.ascii	"__UINT_FAST32_MAX__ 0xffffffffU\000"
.LASF151:
	.ascii	"__FLT_MAX_EXP__ 128\000"
.LASF17:
	.ascii	"__SIZEOF_LONG__ 4\000"
.LASF905:
	.ascii	"reg_addr1\000"
.LASF21:
	.ascii	"__SIZEOF_DOUBLE__ 8\000"
.LASF114:
	.ascii	"__INT_LEAST32_WIDTH__ 32\000"
.LASF492:
	.ascii	"UINT_LEAST32_MAX UINT32_MAX\000"
.LASF903:
	.ascii	"calc_temp\000"
.LASF245:
	.ascii	"__DEC64_MAX__ 9.999999999999999E384DD\000"
.LASF761:
	.ascii	"__mbtowc\000"
.LASF503:
	.ascii	"UINT_FAST16_MAX UINT32_MAX\000"
.LASF937:
	.ascii	"bme680_init\000"
.LASF369:
	.ascii	"__UTA_FBIT__ 64\000"
.LASF687:
	.ascii	"BME680_GH1_REG (37)\000"
.LASF153:
	.ascii	"__FLT_DECIMAL_DIG__ 9\000"
.LASF750:
	.ascii	"date_format\000"
.LASF112:
	.ascii	"__INT_LEAST32_MAX__ 0x7fffffffL\000"
.LASF48:
	.ascii	"__UINT64_TYPE__ long long unsigned int\000"
.LASF703:
	.ascii	"uint8_t\000"
.LASF186:
	.ascii	"__LDBL_EPSILON__ 1.1\000"
.LASF598:
	.ascii	"BME680_OS_16X UINT8_C(5)\000"
.LASF373:
	.ascii	"__GNUC_STDC_INLINE__ 1\000"
.LASF760:
	.ascii	"__wctomb\000"
.LASF265:
	.ascii	"__FRACT_FBIT__ 15\000"
.LASF329:
	.ascii	"__LLACCUM_EPSILON__ 0x1P-31LLK\000"
.LASF922:
	.ascii	"tmp_pow_mode\000"
.LASF7:
	.ascii	"__GNUC_PATCHLEVEL__ 1\000"
.LASF382:
	.ascii	"__GCC_ATOMIC_CHAR32_T_LOCK_FREE 2\000"
.LASF912:
	.ascii	"duration\000"
.LASF840:
	.ascii	"nb_conv\000"
.LASF120:
	.ascii	"__UINT_LEAST16_MAX__ 0xffff\000"
.LASF923:
	.ascii	"pow_mode\000"
.LASF315:
	.ascii	"__LACCUM_FBIT__ 31\000"
.LASF325:
	.ascii	"__LLACCUM_FBIT__ 31\000"
.LASF268:
	.ascii	"__FRACT_MAX__ 0X7FFFP-15R\000"
.LASF211:
	.ascii	"__FLT64_MAX_10_EXP__ 308\000"
.LASF564:
	.ascii	"BME680_E_COM_FAIL INT8_C(-2)\000"
.LASF216:
	.ascii	"__FLT64_DENORM_MIN__ 1.1\000"
.LASF837:
	.ascii	"os_pres\000"
.LASF63:
	.ascii	"__UINT_FAST32_TYPE__ unsigned int\000"
.LASF705:
	.ascii	"unsigned char\000"
.LASF3:
	.ascii	"__STDC_UTF_32__ 1\000"
.LASF477:
	.ascii	"INT64_MAX 9223372036854775807LL\000"
.LASF296:
	.ascii	"__SACCUM_IBIT__ 8\000"
.LASF152:
	.ascii	"__FLT_MAX_10_EXP__ 38\000"
.LASF252:
	.ascii	"__DEC128_MAX__ 9.999999999999999999999999999999999E"
	.ascii	"6144DL\000"
.LASF250:
	.ascii	"__DEC128_MAX_EXP__ 6145\000"
.LASF141:
	.ascii	"__GCC_IEC_559 0\000"
.LASF736:
	.ascii	"n_sep_by_space\000"
.LASF646:
	.ascii	"BME680_MEM_PAGE_MSK UINT8_C(0x10)\000"
.LASF130:
	.ascii	"__INT_FAST32_MAX__ 0x7fffffff\000"
.LASF10:
	.ascii	"__ATOMIC_SEQ_CST 5\000"
.LASF606:
	.ascii	"BME680_FILTER_SIZE_127 UINT8_C(7)\000"
.LASF476:
	.ascii	"INT64_MIN (-9223372036854775807LL-1)\000"
.LASF805:
	.ascii	"gas_resistance\000"
.LASF520:
	.ascii	"INTMAX_C(x) (x ##LL)\000"
.LASF103:
	.ascii	"__UINT16_MAX__ 0xffff\000"
.LASF343:
	.ascii	"__TQ_FBIT__ 127\000"
.LASF867:
	.ascii	"reg_addr\000"
.LASF518:
	.ascii	"INT64_C(x) (x ##LL)\000"
.LASF781:
	.ascii	"__RAL_data_utf8_space\000"
.LASF349:
	.ascii	"__USQ_FBIT__ 32\000"
.LASF172:
	.ascii	"__DBL_DENORM_MIN__ ((double)1.1)\000"
.LASF471:
	.ascii	"INT16_MIN (-32767-1)\000"
.LASF635:
	.ascii	"BME680_OSH_MSK UINT8_C(0X07)\000"
.LASF19:
	.ascii	"__SIZEOF_SHORT__ 2\000"
.LASF330:
	.ascii	"__ULLACCUM_FBIT__ 32\000"
.LASF738:
	.ascii	"n_sign_posn\000"
.LASF593:
	.ascii	"BME680_OS_NONE UINT8_C(0)\000"
.LASF863:
	.ascii	"value\000"
.LASF168:
	.ascii	"__DBL_DECIMAL_DIG__ 17\000"
.LASF22:
	.ascii	"__SIZEOF_LONG_DOUBLE__ 8\000"
.LASF664:
	.ascii	"BME680_P4_MSB_REG (12)\000"
.LASF803:
	.ascii	"pressure\000"
.LASF391:
	.ascii	"__PRAGMA_REDEFINE_EXTNAME 1\000"
.LASF34:
	.ascii	"__WCHAR_TYPE__ unsigned int\000"
.LASF720:
	.ascii	"char\000"
.LASF366:
	.ascii	"__USA_IBIT__ 16\000"
.LASF377:
	.ascii	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1\000"
.LASF614:
	.ascii	"BME680_RUN_GAS_ENABLE UINT8_C(1)\000"
.LASF64:
	.ascii	"__UINT_FAST64_TYPE__ long long unsigned int\000"
.LASF888:
	.ascii	"calc_gas_resistance\000"
.LASF608:
	.ascii	"BME680_FORCED_MODE UINT8_C(1)\000"
.LASF499:
	.ascii	"INT_FAST16_MAX INT32_MAX\000"
.LASF485:
	.ascii	"INT_LEAST64_MIN INT64_MIN\000"
.LASF230:
	.ascii	"__FLT32X_DENORM_MIN__ 1.1\000"
.LASF261:
	.ascii	"__USFRACT_IBIT__ 0\000"
.LASF113:
	.ascii	"__INT32_C(c) c ## L\000"
.LASF685:
	.ascii	"BME680_GH2_LSB_REG (35)\000"
.LASF262:
	.ascii	"__USFRACT_MIN__ 0.0UHR\000"
.LASF449:
	.ascii	"__SIZEOF_WCHAR_T 4\000"
.LASF436:
	.ascii	"__ARM_NEON\000"
.LASF874:
	.ascii	"adc_gas_res\000"
.LASF941:
	.ascii	"timeval\000"
.LASF180:
	.ascii	"__LDBL_MAX_EXP__ 1024\000"
.LASF515:
	.ascii	"UINT16_C(x) (x ##U)\000"
.LASF884:
	.ascii	"var3\000"
.LASF933:
	.ascii	"bme680_set_regs\000"
.LASF895:
	.ascii	"var6\000"
.LASF173:
	.ascii	"__DBL_HAS_DENORM__ 1\000"
.LASF747:
	.ascii	"month_names\000"
.LASF882:
	.ascii	"var1\000"
.LASF883:
	.ascii	"var2\000"
.LASF778:
	.ascii	"__RAL_c_locale_abbrev_month_names\000"
.LASF885:
	.ascii	"var4\000"
.LASF886:
	.ascii	"var5\000"
.LASF359:
	.ascii	"__DA_FBIT__ 31\000"
.LASF463:
	.ascii	"NRF52840_XXAA 1\000"
.LASF109:
	.ascii	"__INT_LEAST16_MAX__ 0x7fff\000"
.LASF727:
	.ascii	"mon_thousands_sep\000"
.LASF655:
	.ascii	"BME680_T2_LSB_REG (1)\000"
.LASF68:
	.ascii	"__has_include_next(STR) __has_include_next__(STR)\000"
.LASF123:
	.ascii	"__UINT32_C(c) c ## UL\000"
.LASF312:
	.ascii	"__UACCUM_MIN__ 0.0UK\000"
.LASF759:
	.ascii	"__towlower\000"
.LASF730:
	.ascii	"negative_sign\000"
.LASF804:
	.ascii	"humidity\000"
.LASF670:
	.ascii	"BME680_P8_MSB_REG (20)\000"
.LASF33:
	.ascii	"__PTRDIFF_TYPE__ int\000"
.LASF422:
	.ascii	"__ARM_ARCH_ISA_THUMB\000"
.LASF545:
	.ascii	"__CTYPE_PRINT (__CTYPE_BLANK | __CTYPE_PUNCT | __CT"
	.ascii	"YPE_UPPER | __CTYPE_LOWER | __CTYPE_DIGIT)\000"
.LASF739:
	.ascii	"int_p_cs_precedes\000"
.LASF722:
	.ascii	"thousands_sep\000"
.LASF789:
	.ascii	"decode\000"
.LASF384:
	.ascii	"__GCC_ATOMIC_SHORT_LOCK_FREE 2\000"
.LASF13:
	.ascii	"__ATOMIC_ACQ_REL 4\000"
.LASF679:
	.ascii	"BME680_H4_REG (29)\000"
.LASF300:
	.ascii	"__USACCUM_FBIT__ 8\000"
.LASF498:
	.ascii	"INT_FAST8_MAX INT8_MAX\000"
.LASF388:
	.ascii	"__GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1\000"
.LASF936:
	.ascii	"bme680_get_regs\000"
.LASF881:
	.ascii	"heatr_res\000"
.LASF448:
	.ascii	"__ELF__ 1\000"
.LASF729:
	.ascii	"positive_sign\000"
.LASF204:
	.ascii	"__FLT32_HAS_QUIET_NAN__ 1\000"
.LASF908:
	.ascii	"set_gas_config\000"
.LASF856:
	.ascii	"info_msg\000"
.LASF189:
	.ascii	"__LDBL_HAS_INFINITY__ 1\000"
.LASF361:
	.ascii	"__TA_FBIT__ 63\000"
.LASF453:
	.ascii	"__SES_VERSION 53201\000"
.LASF225:
	.ascii	"__FLT32X_MAX_10_EXP__ 308\000"
.LASF637:
	.ascii	"BME680_RUN_GAS_MSK UINT8_C(0x10)\000"
.LASF106:
	.ascii	"__INT_LEAST8_MAX__ 0x7f\000"
.LASF600:
	.ascii	"BME680_FILTER_SIZE_1 UINT8_C(1)\000"
.LASF820:
	.ascii	"par_p1\000"
.LASF821:
	.ascii	"par_p2\000"
.LASF452:
	.ascii	"__HEAP_SIZE__ 8192\000"
.LASF823:
	.ascii	"par_p4\000"
.LASF824:
	.ascii	"par_p5\000"
.LASF118:
	.ascii	"__UINT_LEAST8_MAX__ 0xff\000"
.LASF826:
	.ascii	"par_p7\000"
.LASF827:
	.ascii	"par_p8\000"
.LASF828:
	.ascii	"par_p9\000"
.LASF506:
	.ascii	"PTRDIFF_MIN INT32_MIN\000"
.LASF772:
	.ascii	"__RAL_codeset_ascii\000"
.LASF161:
	.ascii	"__FP_FAST_FMAF 1\000"
.LASF830:
	.ascii	"t_fine\000"
.LASF766:
	.ascii	"__RAL_locale_t\000"
.LASF651:
	.ascii	"BME680_FILTER_POS UINT8_C(2)\000"
.LASF111:
	.ascii	"__INT_LEAST16_WIDTH__ 16\000"
.LASF280:
	.ascii	"__ULFRACT_FBIT__ 32\000"
.LASF145:
	.ascii	"__DEC_EVAL_METHOD__ 2\000"
.LASF547:
	.ascii	"__MAX_CATEGORY 5\000"
.LASF433:
	.ascii	"__ARM_FEATURE_FP16_FML\000"
.LASF509:
	.ascii	"INTPTR_MIN INT32_MIN\000"
.LASF171:
	.ascii	"__DBL_EPSILON__ ((double)1.1)\000"
.LASF571:
	.ascii	"BME680_ADDR_RES_HEAT_VAL_ADDR UINT8_C(0x00)\000"
.LASF542:
	.ascii	"__CTYPE_ALPHA (__CTYPE_UPPER | __CTYPE_LOWER)\000"
.LASF247:
	.ascii	"__DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD\000"
.LASF264:
	.ascii	"__USFRACT_EPSILON__ 0x1P-8UHR\000"
.LASF483:
	.ascii	"INT_LEAST16_MIN INT16_MIN\000"
.LASF77:
	.ascii	"__WINT_MAX__ 0xffffffffU\000"
.LASF260:
	.ascii	"__USFRACT_FBIT__ 8\000"
.LASF748:
	.ascii	"abbrev_month_names\000"
.LASF328:
	.ascii	"__LLACCUM_MAX__ 0X7FFFFFFFFFFFFFFFP-31LLK\000"
.LASF627:
	.ascii	"BME680_GAS_SENSOR_SEL (BME680_GAS_MEAS_SEL | BME680"
	.ascii	"_RUN_GAS_SEL | BME680_NBCONV_SEL)\000"
.LASF372:
	.ascii	"__USER_LABEL_PREFIX__ \000"
.LASF105:
	.ascii	"__UINT64_MAX__ 0xffffffffffffffffULL\000"
.LASF765:
	.ascii	"codeset\000"
.LASF692:
	.ascii	"BME680_REG_HUM_INDEX UINT8_C(2)\000"
.LASF104:
	.ascii	"__UINT32_MAX__ 0xffffffffUL\000"
.LASF902:
	.ascii	"temp_adc\000"
.LASF935:
	.ascii	"index\000"
.LASF89:
	.ascii	"__SIZE_WIDTH__ 32\000"
.LASF396:
	.ascii	"__ARM_FEATURE_QBIT 1\000"
.LASF408:
	.ascii	"__ARM_FEATURE_CLZ 1\000"
.LASF626:
	.ascii	"BME680_NBCONV_SEL UINT16_C(128)\000"
.LASF434:
	.ascii	"__ARM_FEATURE_FMA 1\000"
.LASF403:
	.ascii	"__ARM_FEATURE_COMPLEX\000"
.LASF835:
	.ascii	"os_hum\000"
.LASF412:
	.ascii	"__ARM_SIZEOF_WCHAR_T 4\000"
.LASF224:
	.ascii	"__FLT32X_MAX_EXP__ 1024\000"
.LASF67:
	.ascii	"__has_include(STR) __has_include__(STR)\000"
.LASF597:
	.ascii	"BME680_OS_8X UINT8_C(4)\000"
.LASF122:
	.ascii	"__UINT_LEAST32_MAX__ 0xffffffffUL\000"
.LASF585:
	.ascii	"BME680_COEFF_ADDR1 UINT8_C(0x89)\000"
.LASF915:
	.ascii	"os_to_meas_cycles\000"
.LASF450:
	.ascii	"__SES_ARM 1\000"
.LASF117:
	.ascii	"__INT_LEAST64_WIDTH__ 64\000"
.LASF159:
	.ascii	"__FLT_HAS_INFINITY__ 1\000"
.LASF521:
	.ascii	"UINTMAX_C(x) (x ##ULL)\000"
.LASF594:
	.ascii	"BME680_OS_1X UINT8_C(1)\000"
.LASF308:
	.ascii	"__ACCUM_MAX__ 0X7FFFFFFFP-15K\000"
.LASF98:
	.ascii	"__INT8_MAX__ 0x7f\000"
.LASF586:
	.ascii	"BME680_COEFF_ADDR2 UINT8_C(0xe1)\000"
.LASF718:
	.ascii	"__wchar\000"
.LASF401:
	.ascii	"__ARM_FEATURE_CRC32\000"
.LASF257:
	.ascii	"__SFRACT_MIN__ (-0.5HR-0.5HR)\000"
.LASF358:
	.ascii	"__SA_IBIT__ 16\000"
.LASF771:
	.ascii	"__RAL_c_locale\000"
.LASF142:
	.ascii	"__GCC_IEC_559_COMPLEX 0\000"
.LASF617:
	.ascii	"BME680_FIELD_DATA_LENGTH UINT8_C(3)\000"
.LASF792:
	.ascii	"__RAL_error_decoder_head\000"
.LASF428:
	.ascii	"__ARM_FP16_FORMAT_IEEE\000"
.LASF5:
	.ascii	"__GNUC__ 9\000"
.LASF753:
	.ascii	"__RAL_locale_data_t\000"
.LASF548:
	.ascii	"__RAL_SIZE_T_DEFINED \000"
.LASF473:
	.ascii	"UINT32_MAX 4294967295UL\000"
.LASF799:
	.ascii	"status\000"
.LASF660:
	.ascii	"BME680_P2_LSB_REG (7)\000"
.LASF236:
	.ascii	"__DEC32_MAX_EXP__ 97\000"
.LASF777:
	.ascii	"__RAL_c_locale_month_names\000"
.LASF144:
	.ascii	"__FLT_EVAL_METHOD_TS_18661_3__ 0\000"
.LASF81:
	.ascii	"__SCHAR_WIDTH__ 8\000"
.LASF589:
	.ascii	"BME680_ENABLE_HEATER UINT8_C(0x00)\000"
.LASF673:
	.ascii	"BME680_P10_REG (23)\000"
.LASF633:
	.ascii	"BME680_OST_MSK UINT8_C(0XE0)\000"
.LASF61:
	.ascii	"__UINT_FAST8_TYPE__ unsigned int\000"
.LASF326:
	.ascii	"__LLACCUM_IBIT__ 32\000"
.LASF269:
	.ascii	"__FRACT_EPSILON__ 0x1P-15R\000"
.LASF930:
	.ascii	"intended_power_mode\000"
.LASF353:
	.ascii	"__UTQ_FBIT__ 128\000"
.LASF570:
	.ascii	"BME680_I_MAX_CORRECTION UINT8_C(2)\000"
.LASF100:
	.ascii	"__INT32_MAX__ 0x7fffffffL\000"
.LASF893:
	.ascii	"calc_humidity\000"
.LASF623:
	.ascii	"BME680_FILTER_SEL UINT16_C(16)\000"
.LASF115:
	.ascii	"__INT_LEAST64_MAX__ 0x7fffffffffffffffLL\000"
.LASF939:
	.ascii	"C:\\nordic\\nRF5_SDK_17.0.2_d674dde\\own_projects\\"
	.ascii	"eigene\\twi_sensor2\\lib\\sensor\\snow_bme680\\bme6"
	.ascii	"80.c\000"
.LASF866:
	.ascii	"set_mem_page\000"
.LASF786:
	.ascii	"__user_get_time_of_day\000"
.LASF201:
	.ascii	"__FLT32_DENORM_MIN__ 1.1\000"
.LASF191:
	.ascii	"__FLT32_MANT_DIG__ 24\000"
.LASF525:
	.ascii	"WINT_MAX 2147483647L\000"
.LASF125:
	.ascii	"__UINT64_C(c) c ## ULL\000"
.LASF56:
	.ascii	"__UINT_LEAST64_TYPE__ long long unsigned int\000"
.LASF522:
	.ascii	"WCHAR_MIN __WCHAR_MIN__\000"
.LASF890:
	.ascii	"calc_gas_res\000"
.LASF381:
	.ascii	"__GCC_ATOMIC_CHAR16_T_LOCK_FREE 2\000"
.LASF615:
	.ascii	"BME680_TMP_BUFFER_LENGTH UINT8_C(40)\000"
.LASF749:
	.ascii	"am_pm_indicator\000"
.LASF879:
	.ascii	"calc_heater_res\000"
.LASF166:
	.ascii	"__DBL_MAX_EXP__ 1024\000"
.LASF734:
	.ascii	"p_sep_by_space\000"
.LASF231:
	.ascii	"__FLT32X_HAS_DENORM__ 1\000"
.LASF147:
	.ascii	"__FLT_MANT_DIG__ 24\000"
.LASF675:
	.ascii	"BME680_H2_LSB_REG (26)\000"
.LASF352:
	.ascii	"__UDQ_IBIT__ 0\000"
.LASF797:
	.ascii	"BME680_I2C_INTF\000"
.LASF899:
	.ascii	"pres_adc\000"
.LASF101:
	.ascii	"__INT64_MAX__ 0x7fffffffffffffffLL\000"
.LASF397:
	.ascii	"__ARM_FEATURE_SAT 1\000"
.LASF538:
	.ascii	"__CTYPE_PUNCT 0x10\000"
.LASF291:
	.ascii	"__ULLFRACT_IBIT__ 0\000"
.LASF742:
	.ascii	"int_n_sep_by_space\000"
.LASF561:
	.ascii	"BME680_SOFT_RESET_CMD UINT8_C(0xb6)\000"
.LASF643:
	.ascii	"BME680_GAS_RANGE_MSK UINT8_C(0x0f)\000"
.LASF642:
	.ascii	"BME680_GAS_INDEX_MSK UINT8_C(0x0f)\000"
.LASF785:
	.ascii	"__user_set_time_of_day\000"
.LASF872:
	.ascii	"adc_pres\000"
.LASF683:
	.ascii	"BME680_T1_LSB_REG (33)\000"
.LASF84:
	.ascii	"__LONG_WIDTH__ 32\000"
.LASF658:
	.ascii	"BME680_P1_LSB_REG (5)\000"
.LASF855:
	.ascii	"new_fields\000"
.LASF274:
	.ascii	"__UFRACT_EPSILON__ 0x1P-16UR\000"
.LASF817:
	.ascii	"par_t1\000"
.LASF818:
	.ascii	"par_t2\000"
.LASF819:
	.ascii	"par_t3\000"
.LASF346:
	.ascii	"__UQQ_IBIT__ 0\000"
.LASF851:
	.ascii	"calib\000"
.LASF386:
	.ascii	"__GCC_ATOMIC_LONG_LOCK_FREE 2\000"
.LASF322:
	.ascii	"__ULACCUM_MIN__ 0.0ULK\000"
.LASF417:
	.ascii	"__ARM_ARCH 7\000"
.LASF672:
	.ascii	"BME680_P9_MSB_REG (22)\000"
.LASF146:
	.ascii	"__FLT_RADIX__ 2\000"
.LASF714:
	.ascii	"long long int\000"
.LASF898:
	.ascii	"calc_pressure\000"
.LASF767:
	.ascii	"__mbstate_s\000"
.LASF405:
	.ascii	"__ARM_FEATURE_CMSE\000"
.LASF624:
	.ascii	"BME680_HCNTRL_SEL UINT16_C(32)\000"
.LASF190:
	.ascii	"__LDBL_HAS_QUIET_NAN__ 1\000"
.LASF85:
	.ascii	"__LONG_LONG_WIDTH__ 64\000"
.LASF187:
	.ascii	"__LDBL_DENORM_MIN__ 1.1\000"
.LASF693:
	.ascii	"BME680_REG_NBCONV_INDEX UINT8_C(1)\000"
.LASF854:
	.ascii	"power_mode\000"
.LASF137:
	.ascii	"__UINT_FAST64_MAX__ 0xffffffffffffffffULL\000"
.LASF622:
	.ascii	"BME680_GAS_MEAS_SEL UINT16_C(8)\000"
.LASF426:
	.ascii	"__ARM_FP\000"
.LASF356:
	.ascii	"__HA_IBIT__ 8\000"
.LASF139:
	.ascii	"__INTPTR_WIDTH__ 32\000"
.LASF387:
	.ascii	"__GCC_ATOMIC_LLONG_LOCK_FREE 1\000"
.LASF501:
	.ascii	"INT_FAST64_MAX INT64_MAX\000"
.LASF210:
	.ascii	"__FLT64_MAX_EXP__ 1024\000"
.LASF831:
	.ascii	"res_heat_range\000"
.LASF169:
	.ascii	"__DBL_MAX__ ((double)1.1)\000"
.LASF859:
	.ascii	"delay_ms\000"
.LASF832:
	.ascii	"res_heat_val\000"
.LASF583:
	.ascii	"BME680_CONF_T_P_MODE_ADDR UINT8_C(0x74)\000"
.LASF413:
	.ascii	"__ARM_ARCH_PROFILE\000"
.LASF44:
	.ascii	"__INT64_TYPE__ long long int\000"
.LASF185:
	.ascii	"__LDBL_MIN__ 1.1\000"
.LASF24:
	.ascii	"__CHAR_BIT__ 8\000"
.LASF392:
	.ascii	"__SIZEOF_WCHAR_T__ 4\000"
.LASF769:
	.ascii	"__category\000"
.LASF704:
	.ascii	"signed char\000"
.LASF662:
	.ascii	"BME680_P3_REG (9)\000"
.LASF273:
	.ascii	"__UFRACT_MAX__ 0XFFFFP-16UR\000"
.LASF649:
	.ascii	"BME680_BIT_H1_DATA_MSK UINT8_C(0x0F)\000"
.LASF55:
	.ascii	"__UINT_LEAST32_TYPE__ long unsigned int\000"
.LASF458:
	.ascii	"BSP_DEFINES_ONLY 1\000"
.LASF674:
	.ascii	"BME680_H2_MSB_REG (25)\000"
.LASF579:
	.ascii	"BME680_CONF_HEAT_CTRL_ADDR UINT8_C(0x70)\000"
.LASF671:
	.ascii	"BME680_P9_LSB_REG (21)\000"
.LASF256:
	.ascii	"__SFRACT_IBIT__ 0\000"
.LASF636:
	.ascii	"BME680_HCTRL_MSK UINT8_C(0x08)\000"
.LASF752:
	.ascii	"date_time_format\000"
.LASF29:
	.ascii	"__BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__\000"
.LASF869:
	.ascii	"buff\000"
.LASF437:
	.ascii	"__ARM_NEON_FP\000"
.LASF921:
	.ascii	"bme680_set_sensor_mode\000"
.LASF656:
	.ascii	"BME680_T2_MSB_REG (2)\000"
.LASF582:
	.ascii	"BME680_MEM_PAGE_ADDR UINT8_C(0xf3)\000"
.LASF696:
	.ascii	"BME680_MAX_OVERFLOW_VAL INT32_C(0x40000000)\000"
.LASF928:
	.ascii	"count\000"
.LASF12:
	.ascii	"__ATOMIC_RELEASE 3\000"
.LASF666:
	.ascii	"BME680_P5_MSB_REG (14)\000"
.LASF351:
	.ascii	"__UDQ_FBIT__ 64\000"
.LASF157:
	.ascii	"__FLT_DENORM_MIN__ 1.1\000"
.LASF275:
	.ascii	"__LFRACT_FBIT__ 31\000"
.LASF181:
	.ascii	"__LDBL_MAX_10_EXP__ 308\000"
.LASF942:
	.ascii	"bme680_intf\000"
.LASF857:
	.ascii	"read\000"
.LASF475:
	.ascii	"INT32_MIN (-2147483647L-1)\000"
.LASF926:
	.ascii	"data_array\000"
.LASF227:
	.ascii	"__FLT32X_MAX__ 1.1\000"
.LASF712:
	.ascii	"unsigned int\000"
.LASF482:
	.ascii	"INT_LEAST8_MIN INT8_MIN\000"
.LASF494:
	.ascii	"INT_FAST8_MIN INT8_MIN\000"
.LASF149:
	.ascii	"__FLT_MIN_EXP__ (-125)\000"
.LASF219:
	.ascii	"__FLT64_HAS_QUIET_NAN__ 1\000"
.LASF301:
	.ascii	"__USACCUM_IBIT__ 8\000"
.LASF439:
	.ascii	"__ARM_ARCH_7EM__ 1\000"
.LASF814:
	.ascii	"par_gh1\000"
.LASF815:
	.ascii	"par_gh2\000"
.LASF217:
	.ascii	"__FLT64_HAS_DENORM__ 1\000"
.LASF148:
	.ascii	"__FLT_DIG__ 6\000"
.LASF314:
	.ascii	"__UACCUM_EPSILON__ 0x1P-16UK\000"
.LASF737:
	.ascii	"p_sign_posn\000"
.LASF143:
	.ascii	"__FLT_EVAL_METHOD__ 0\000"
.LASF829:
	.ascii	"par_p10\000"
.LASF638:
	.ascii	"BME680_MODE_MSK UINT8_C(0x03)\000"
.LASF70:
	.ascii	"__SCHAR_MAX__ 0x7f\000"
.LASF127:
	.ascii	"__INT_FAST8_WIDTH__ 32\000"
.LASF495:
	.ascii	"INT_FAST16_MIN INT32_MIN\000"
.LASF862:
	.ascii	"boundary_check\000"
.LASF406:
	.ascii	"__ARM_FEATURE_LDREX\000"
.LASF345:
	.ascii	"__UQQ_FBIT__ 8\000"
.LASF841:
	.ascii	"heatr_ctrl\000"
.LASF535:
	.ascii	"__CTYPE_LOWER 0x02\000"
.LASF242:
	.ascii	"__DEC64_MIN_EXP__ (-382)\000"
.LASF313:
	.ascii	"__UACCUM_MAX__ 0XFFFFFFFFP-16UK\000"
.LASF278:
	.ascii	"__LFRACT_MAX__ 0X7FFFFFFFP-31LR\000"
.LASF394:
	.ascii	"__SIZEOF_PTRDIFF_T__ 4\000"
.LASF795:
	.ascii	"bme680_delay_fptr_t\000"
.LASF0:
	.ascii	"__STDC__ 1\000"
.LASF595:
	.ascii	"BME680_OS_2X UINT8_C(2)\000"
.LASF451:
	.ascii	"__ARM_ARCH_FPV4_SP_D16__ 1\000"
.LASF443:
	.ascii	"__ARM_FEATURE_IDIV 1\000"
.LASF825:
	.ascii	"par_p6\000"
.LASF30:
	.ascii	"__FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__\000"
.LASF45:
	.ascii	"__UINT8_TYPE__ unsigned char\000"
.LASF170:
	.ascii	"__DBL_MIN__ ((double)1.1)\000"
.LASF493:
	.ascii	"UINT_LEAST64_MAX UINT64_MAX\000"
.LASF446:
	.ascii	"__ARM_FEATURE_COPROC 15\000"
.LASF82:
	.ascii	"__SHRT_WIDTH__ 16\000"
.LASF592:
	.ascii	"BME680_ENABLE_GAS_MEAS UINT8_C(0x01)\000"
.LASF248:
	.ascii	"__DEC128_MANT_DIG__ 34\000"
.LASF699:
	.ascii	"BME680_GET_BITS(reg_data,bitname) ((reg_data & (bit"
	.ascii	"name ##_MSK)) >> (bitname ##_POS))\000"
.LASF773:
	.ascii	"__RAL_codeset_utf8\000"
.LASF365:
	.ascii	"__USA_FBIT__ 16\000"
.LASF873:
	.ascii	"adc_hum\000"
.LASF59:
	.ascii	"__INT_FAST32_TYPE__ int\000"
.LASF645:
	.ascii	"BME680_HEAT_STAB_MSK UINT8_C(0x10)\000"
.LASF179:
	.ascii	"__LDBL_MIN_10_EXP__ (-307)\000"
.LASF838:
	.ascii	"filter\000"
.LASF160:
	.ascii	"__FLT_HAS_QUIET_NAN__ 1\000"
.LASF380:
	.ascii	"__GCC_ATOMIC_CHAR_LOCK_FREE 2\000"
.LASF279:
	.ascii	"__LFRACT_EPSILON__ 0x1P-31LR\000"
.LASF700:
	.ascii	"BME680_SET_BITS_POS_0(reg_data,bitname,data) ((reg_"
	.ascii	"data & ~(bitname ##_MSK)) | (data & bitname ##_MSK)"
	.ascii	")\000"
.LASF909:
	.ascii	"get_calib_data\000"
.LASF481:
	.ascii	"UINTMAX_MAX 18446744073709551615ULL\000"
.LASF721:
	.ascii	"decimal_point\000"
.LASF411:
	.ascii	"__ARM_SIZEOF_MINIMAL_ENUM 1\000"
.LASF20:
	.ascii	"__SIZEOF_FLOAT__ 4\000"
.LASF415:
	.ascii	"__arm__ 1\000"
.LASF691:
	.ascii	"BME680_REG_PRES_INDEX UINT8_C(4)\000"
.LASF917:
	.ascii	"bme680_set_profile_dur\000"
.LASF41:
	.ascii	"__INT8_TYPE__ signed char\000"
.LASF194:
	.ascii	"__FLT32_MIN_10_EXP__ (-37)\000"
.LASF429:
	.ascii	"__ARM_FP16_FORMAT_ALTERNATIVE\000"
.LASF536:
	.ascii	"__CTYPE_DIGIT 0x04\000"
.LASF474:
	.ascii	"INT32_MAX 2147483647L\000"
.LASF680:
	.ascii	"BME680_H5_REG (30)\000"
.LASF782:
	.ascii	"__RAL_data_utf8_plus\000"
.LASF796:
	.ascii	"BME680_SPI_INTF\000"
.LASF677:
	.ascii	"BME680_H1_MSB_REG (27)\000"
.LASF487:
	.ascii	"INT_LEAST16_MAX INT16_MAX\000"
.LASF362:
	.ascii	"__TA_IBIT__ 64\000"
.LASF605:
	.ascii	"BME680_FILTER_SIZE_63 UINT8_C(6)\000"
.LASF554:
	.ascii	"BME680_I2C_ADDR_SECONDARY UINT8_C(0x77)\000"
.LASF400:
	.ascii	"__ARM_FEATURE_QRDMX\000"
.LASF574:
	.ascii	"BME680_ADDR_SENS_CONF_START UINT8_C(0x5A)\000"
.LASF423:
	.ascii	"__ARM_ARCH_ISA_THUMB 2\000"
.LASF74:
	.ascii	"__LONG_LONG_MAX__ 0x7fffffffffffffffLL\000"
.LASF793:
	.ascii	"long double\000"
.LASF271:
	.ascii	"__UFRACT_IBIT__ 0\000"
.LASF404:
	.ascii	"__ARM_32BIT_STATE 1\000"
.LASF107:
	.ascii	"__INT8_C(c) c\000"
.LASF276:
	.ascii	"__LFRACT_IBIT__ 0\000"
.LASF460:
	.ascii	"FLOAT_ABI_HARD 1\000"
.LASF164:
	.ascii	"__DBL_MIN_EXP__ (-1021)\000"
.LASF625:
	.ascii	"BME680_RUN_GAS_SEL UINT16_C(64)\000"
.LASF491:
	.ascii	"UINT_LEAST16_MAX UINT16_MAX\000"
.LASF192:
	.ascii	"__FLT32_DIG__ 6\000"
.LASF496:
	.ascii	"INT_FAST32_MIN INT32_MIN\000"
.LASF505:
	.ascii	"UINT_FAST64_MAX UINT64_MAX\000"
.LASF551:
	.ascii	"offsetof(s,m) __builtin_offsetof(s, m)\000"
.LASF842:
	.ascii	"run_gas\000"
.LASF694:
	.ascii	"BME680_REG_RUN_GAS_INDEX UINT8_C(1)\000"
.LASF188:
	.ascii	"__LDBL_HAS_DENORM__ 1\000"
.LASF390:
	.ascii	"__HAVE_SPECULATION_SAFE_VALUE 1\000"
.LASF470:
	.ascii	"UINT16_MAX 65535\000"
.LASF845:
	.ascii	"bme680_dev\000"
.LASF307:
	.ascii	"__ACCUM_MIN__ (-0X1P15K-0X1P15K)\000"
.LASF907:
	.ascii	"reg_data\000"
.LASF398:
	.ascii	"__ARM_FEATURE_CRYPTO\000"
.LASF51:
	.ascii	"__INT_LEAST32_TYPE__ long int\000"
.LASF556:
	.ascii	"BME680_COEFF_SIZE UINT8_C(41)\000"
.LASF650:
	.ascii	"BME680_GAS_MEAS_POS UINT8_C(4)\000"
.LASF124:
	.ascii	"__UINT_LEAST64_MAX__ 0xffffffffffffffffULL\000"
.LASF266:
	.ascii	"__FRACT_IBIT__ 0\000"
.LASF11:
	.ascii	"__ATOMIC_ACQUIRE 2\000"
.LASF676:
	.ascii	"BME680_H1_LSB_REG (26)\000"
.LASF526:
	.ascii	"__stddef_H \000"
.LASF26:
	.ascii	"__ORDER_LITTLE_ENDIAN__ 1234\000"
.LASF602:
	.ascii	"BME680_FILTER_SIZE_7 UINT8_C(3)\000"
.LASF754:
	.ascii	"__isctype\000"
.LASF806:
	.ascii	"bme680_calib_data\000"
.LASF241:
	.ascii	"__DEC64_MANT_DIG__ 16\000"
.LASF716:
	.ascii	"long long unsigned int\000"
.LASF150:
	.ascii	"__FLT_MIN_10_EXP__ (-37)\000"
.LASF486:
	.ascii	"INT_LEAST8_MAX INT8_MAX\000"
.LASF669:
	.ascii	"BME680_P8_LSB_REG (19)\000"
.LASF321:
	.ascii	"__ULACCUM_IBIT__ 32\000"
.LASF488:
	.ascii	"INT_LEAST32_MAX INT32_MAX\000"
.LASF71:
	.ascii	"__SHRT_MAX__ 0x7fff\000"
.LASF334:
	.ascii	"__ULLACCUM_EPSILON__ 0x1P-32ULLK\000"
.LASF741:
	.ascii	"int_p_sep_by_space\000"
.LASF418:
	.ascii	"__APCS_32__ 1\000"
.LASF341:
	.ascii	"__DQ_FBIT__ 63\000"
.LASF607:
	.ascii	"BME680_SLEEP_MODE UINT8_C(0)\000"
.LASF708:
	.ascii	"uint16_t\000"
.LASF540:
	.ascii	"__CTYPE_BLANK 0x40\000"
.LASF348:
	.ascii	"__UHQ_IBIT__ 0\000"
.LASF459:
	.ascii	"CONFIG_GPIO_AS_PINRESET 1\000"
.LASF378:
	.ascii	"__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1\000"
.LASF58:
	.ascii	"__INT_FAST16_TYPE__ int\000"
.LASF297:
	.ascii	"__SACCUM_MIN__ (-0X1P7HK-0X1P7HK)\000"
.LASF283:
	.ascii	"__ULFRACT_MAX__ 0XFFFFFFFFP-32ULR\000"
.LASF54:
	.ascii	"__UINT_LEAST16_TYPE__ short unsigned int\000"
.LASF681:
	.ascii	"BME680_H6_REG (31)\000"
.LASF156:
	.ascii	"__FLT_EPSILON__ 1.1\000"
.LASF318:
	.ascii	"__LACCUM_MAX__ 0X7FFFFFFFFFFFFFFFP-31LK\000"
.LASF38:
	.ascii	"__CHAR16_TYPE__ short unsigned int\000"
.LASF906:
	.ascii	"reg_addr2\000"
.LASF221:
	.ascii	"__FLT32X_DIG__ 15\000"
.LASF155:
	.ascii	"__FLT_MIN__ 1.1\000"
.LASF560:
	.ascii	"BME680_FIELD_ADDR_OFFSET UINT8_C(17)\000"
.LASF15:
	.ascii	"__FINITE_MATH_ONLY__ 0\000"
.LASF128:
	.ascii	"__INT_FAST16_MAX__ 0x7fffffff\000"
.LASF871:
	.ascii	"adc_temp\000"
.LASF686:
	.ascii	"BME680_GH2_MSB_REG (36)\000"
.LASF568:
	.ascii	"BME680_W_NO_NEW_DATA INT8_C(2)\000"
.LASF484:
	.ascii	"INT_LEAST32_MIN INT32_MIN\000"
.LASF678:
	.ascii	"BME680_H3_REG (28)\000"
.LASF197:
	.ascii	"__FLT32_DECIMAL_DIG__ 9\000"
.LASF938:
	.ascii	"GNU C99 9.3.1 20200408 (release) -fmessage-length=0"
	.ascii	" -mcpu=cortex-m4 -mlittle-endian -mfloat-abi=hard -"
	.ascii	"mfpu=fpv4-sp-d16 -mthumb -mtp=soft -munaligned-acce"
	.ascii	"ss -std=gnu99 -g3 -gpubnames -fomit-frame-pointer -"
	.ascii	"fno-dwarf2-cfi-asm -fno-builtin -ffunction-sections"
	.ascii	" -fdata-sections -fshort-enums -fno-common\000"
.LASF282:
	.ascii	"__ULFRACT_MIN__ 0.0ULR\000"
.LASF916:
	.ascii	"bme680_get_profile_dur\000"
.LASF462:
	.ascii	"NO_VTOR_CONFIG 1\000"
.LASF342:
	.ascii	"__DQ_IBIT__ 0\000"
.LASF468:
	.ascii	"INT8_MAX 127\000"
.LASF43:
	.ascii	"__INT32_TYPE__ long int\000"
.LASF591:
	.ascii	"BME680_DISABLE_GAS_MEAS UINT8_C(0x00)\000"
.LASF697:
	.ascii	"BME680_CONCAT_BYTES(msb,lsb) (((uint16_t)msb << 8) "
	.ascii	"| (uint16_t)lsb)\000"
.LASF801:
	.ascii	"meas_index\000"
.LASF919:
	.ascii	"bme680_get_sensor_mode\000"
.LASF456:
	.ascii	"DEBUG_NRF 1\000"
.LASF584:
	.ascii	"BME680_CONF_ODR_FILT_ADDR UINT8_C(0x75)\000"
.LASF878:
	.ascii	"durval\000"
.LASF864:
	.ascii	"rslt\000"
.LASF911:
	.ascii	"temp_var\000"
.LASF527:
	.ascii	"__crossworks_H \000"
.LASF800:
	.ascii	"gas_index\000"
.LASF354:
	.ascii	"__UTQ_IBIT__ 0\000"
.LASF357:
	.ascii	"__SA_FBIT__ 15\000"
.LASF802:
	.ascii	"temperature\000"
.LASF723:
	.ascii	"grouping\000"
.LASF441:
	.ascii	"__ARM_EABI__ 1\000"
.LASF924:
	.ascii	"bme680_get_sensor_settings\000"
.LASF689:
	.ascii	"BME680_REG_FILTER_INDEX UINT8_C(5)\000"
.LASF421:
	.ascii	"__THUMBEL__ 1\000"
.LASF465:
	.ascii	"BME680_DEFS_H_ \000"
.LASF395:
	.ascii	"__ARM_FEATURE_DSP 1\000"
.LASF336:
	.ascii	"__QQ_IBIT__ 0\000"
.LASF653:
	.ascii	"BME680_OSP_POS UINT8_C(2)\000"
.LASF682:
	.ascii	"BME680_H7_REG (32)\000"
.LASF546:
	.ascii	"__RAL_WCHAR_T __WCHAR_TYPE__\000"
.LASF199:
	.ascii	"__FLT32_MIN__ 1.1\000"
.LASF466:
	.ascii	"__stdint_H \000"
.LASF609:
	.ascii	"BME680_RESET_PERIOD UINT32_C(10)\000"
.LASF37:
	.ascii	"__UINTMAX_TYPE__ long long unsigned int\000"
.LASF350:
	.ascii	"__USQ_IBIT__ 0\000"
.LASF6:
	.ascii	"__GNUC_MINOR__ 3\000"
.LASF746:
	.ascii	"abbrev_day_names\000"
.LASF539:
	.ascii	"__CTYPE_CNTRL 0x20\000"
.LASF860:
	.ascii	"com_rslt\000"
.LASF409:
	.ascii	"__ARM_FEATURE_NUMERIC_MAXMIN\000"
.LASF587:
	.ascii	"BME680_CHIP_ID_ADDR UINT8_C(0xd0)\000"
.LASF36:
	.ascii	"__INTMAX_TYPE__ long long int\000"
.LASF385:
	.ascii	"__GCC_ATOMIC_INT_LOCK_FREE 2\000"
.LASF461:
	.ascii	"INITIALIZE_USER_SECTIONS 1\000"
.LASF698:
	.ascii	"BME680_SET_BITS(reg_data,bitname,data) ((reg_data &"
	.ascii	" ~(bitname ##_MSK)) | ((data << bitname ##_POS) & b"
	.ascii	"itname ##_MSK))\000"
.LASF774:
	.ascii	"__RAL_ascii_ctype_map\000"
.LASF431:
	.ascii	"__ARM_FEATURE_FP16_SCALAR_ARITHMETIC\000"
.LASF304:
	.ascii	"__USACCUM_EPSILON__ 0x1P-8UHK\000"
.LASF175:
	.ascii	"__DBL_HAS_QUIET_NAN__ 1\000"
.LASF288:
	.ascii	"__LLFRACT_MAX__ 0X7FFFFFFFFFFFFFFFP-63LLR\000"
.LASF202:
	.ascii	"__FLT32_HAS_DENORM__ 1\000"
.LASF610:
	.ascii	"BME680_MEM_PAGE0 UINT8_C(0x10)\000"
.LASF632:
	.ascii	"BME680_FILTER_MSK UINT8_C(0X1C)\000"
.LASF298:
	.ascii	"__SACCUM_MAX__ 0X7FFFP-7HK\000"
.LASF65:
	.ascii	"__INTPTR_TYPE__ int\000"
.LASF755:
	.ascii	"__toupper\000"
.LASF66:
	.ascii	"__UINTPTR_TYPE__ unsigned int\000"
.LASF464:
	.ascii	"BME680_H_ \000"
.LASF371:
	.ascii	"__REGISTER_PREFIX__ \000"
.LASF254:
	.ascii	"__DEC128_SUBNORMAL_MIN__ 0.000000000000000000000000"
	.ascii	"000000001E-6143DL\000"
.LASF163:
	.ascii	"__DBL_DIG__ 15\000"
.LASF284:
	.ascii	"__ULFRACT_EPSILON__ 0x1P-32ULR\000"
.LASF523:
	.ascii	"WCHAR_MAX __WCHAR_MAX__\000"
.LASF663:
	.ascii	"BME680_P4_LSB_REG (11)\000"
.LASF23:
	.ascii	"__SIZEOF_SIZE_T__ 4\000"
.LASF763:
	.ascii	"name\000"
.LASF251:
	.ascii	"__DEC128_MIN__ 1E-6143DL\000"
.LASF575:
	.ascii	"BME680_ADDR_GAS_CONF_START UINT8_C(0x64)\000"
.LASF914:
	.ascii	"meas_cycles\000"
.LASF665:
	.ascii	"BME680_P5_LSB_REG (13)\000"
.LASF918:
	.ascii	"bme680_get_sensor_data\000"
.LASF306:
	.ascii	"__ACCUM_IBIT__ 16\000"
.LASF25:
	.ascii	"__BIGGEST_ALIGNMENT__ 8\000"
.LASF732:
	.ascii	"frac_digits\000"
.LASF725:
	.ascii	"currency_symbol\000"
.LASF497:
	.ascii	"INT_FAST64_MIN INT64_MIN\000"
.LASF707:
	.ascii	"short int\000"
.LASF270:
	.ascii	"__UFRACT_FBIT__ 16\000"
.LASF121:
	.ascii	"__UINT16_C(c) c\000"
.LASF715:
	.ascii	"uint64_t\000"
.LASF368:
	.ascii	"__UDA_IBIT__ 32\000"
.LASF920:
	.ascii	"mode\000"
.LASF374:
	.ascii	"__NO_INLINE__ 1\000"
.LASF639:
	.ascii	"BME680_RHRANGE_MSK UINT8_C(0x30)\000"
.LASF9:
	.ascii	"__ATOMIC_RELAXED 0\000"
.LASF717:
	.ascii	"__state\000"
.LASF445:
	.ascii	"__ARM_FEATURE_COPROC\000"
.LASF852:
	.ascii	"tph_sett\000"
.LASF581:
	.ascii	"BME680_CONF_OS_H_ADDR UINT8_C(0x72)\000"
.LASF174:
	.ascii	"__DBL_HAS_INFINITY__ 1\000"
.LASF95:
	.ascii	"__SIG_ATOMIC_MAX__ 0x7fffffff\000"
.LASF379:
	.ascii	"__GCC_ATOMIC_BOOL_LOCK_FREE 2\000"
.LASF480:
	.ascii	"INTMAX_MAX 9223372036854775807LL\000"
.LASF661:
	.ascii	"BME680_P2_MSB_REG (8)\000"
.LASF442:
	.ascii	"__ARM_ARCH_EXT_IDIV__ 1\000"
.LASF244:
	.ascii	"__DEC64_MIN__ 1E-383DD\000"
.LASF728:
	.ascii	"mon_grouping\000"
.LASF868:
	.ascii	"read_field_data\000"
.LASF931:
	.ascii	"bme680_soft_reset\000"
.LASF508:
	.ascii	"SIZE_MAX INT32_MAX\000"
.LASF798:
	.ascii	"bme680_field_data\000"
.LASF320:
	.ascii	"__ULACCUM_FBIT__ 32\000"
.LASF489:
	.ascii	"INT_LEAST64_MAX INT64_MAX\000"
.LASF563:
	.ascii	"BME680_E_NULL_PTR INT8_C(-1)\000"
.LASF524:
	.ascii	"WINT_MIN (-2147483647L-1)\000"
.LASF99:
	.ascii	"__INT16_MAX__ 0x7fff\000"
.LASF641:
	.ascii	"BME680_NEW_DATA_MSK UINT8_C(0x80)\000"
.LASF758:
	.ascii	"__towupper\000"
.LASF83:
	.ascii	"__INT_WIDTH__ 32\000"
.LASF410:
	.ascii	"__ARM_FEATURE_SIMD32 1\000"
.LASF198:
	.ascii	"__FLT32_MAX__ 1.1\000"
.LASF537:
	.ascii	"__CTYPE_SPACE 0x08\000"
.LASF335:
	.ascii	"__QQ_FBIT__ 7\000"
.LASF657:
	.ascii	"BME680_T3_REG (3)\000"
.LASF647:
	.ascii	"BME680_SPI_RD_MSK UINT8_C(0x80)\000"
.LASF97:
	.ascii	"__SIG_ATOMIC_WIDTH__ 32\000"
.LASF740:
	.ascii	"int_n_cs_precedes\000"
.LASF870:
	.ascii	"gas_range\000"
.LASF783:
	.ascii	"__RAL_data_utf8_minus\000"
.LASF684:
	.ascii	"BME680_T1_MSB_REG (34)\000"
.LASF370:
	.ascii	"__UTA_IBIT__ 64\000"
.LASF331:
	.ascii	"__ULLACCUM_IBIT__ 32\000"
.LASF743:
	.ascii	"int_p_sign_posn\000"
.LASF294:
	.ascii	"__ULLFRACT_EPSILON__ 0x1P-64ULLR\000"
.LASF565:
	.ascii	"BME680_E_DEV_NOT_FOUND INT8_C(-3)\000"
.LASF847:
	.ascii	"dev_id\000"
.LASF393:
	.ascii	"__SIZEOF_WINT_T__ 4\000"
.LASF654:
	.ascii	"BME680_RUN_GAS_POS UINT8_C(4)\000"
.LASF399:
	.ascii	"__ARM_FEATURE_UNALIGNED 1\000"
.LASF447:
	.ascii	"__GXX_TYPEINFO_EQUALITY_INLINE 0\000"
.LASF183:
	.ascii	"__LDBL_DECIMAL_DIG__ 17\000"
.LASF850:
	.ascii	"amb_temp\000"
.LASF317:
	.ascii	"__LACCUM_MIN__ (-0X1P31LK-0X1P31LK)\000"
.LASF126:
	.ascii	"__INT_FAST8_MAX__ 0x7fffffff\000"
.LASF757:
	.ascii	"__iswctype\000"
.LASF701:
	.ascii	"BME680_GET_BITS_POS_0(reg_data,bitname) (reg_data &"
	.ascii	" (bitname ##_MSK))\000"
.LASF235:
	.ascii	"__DEC32_MIN_EXP__ (-94)\000"
.LASF332:
	.ascii	"__ULLACCUM_MIN__ 0.0ULLK\000"
.LASF131:
	.ascii	"__INT_FAST32_WIDTH__ 32\000"
.LASF27:
	.ascii	"__ORDER_BIG_ENDIAN__ 4321\000"
.LASF877:
	.ascii	"factor\000"
.LASF541:
	.ascii	"__CTYPE_XDIGIT 0x80\000"
.LASF894:
	.ascii	"hum_adc\000"
.LASF444:
	.ascii	"__ARM_ASM_SYNTAX_UNIFIED__ 1\000"
.LASF775:
	.ascii	"__RAL_c_locale_day_names\000"
.LASF836:
	.ascii	"os_temp\000"
.LASF47:
	.ascii	"__UINT32_TYPE__ long unsigned int\000"
.LASF402:
	.ascii	"__ARM_FEATURE_DOTPROD\000"
.LASF599:
	.ascii	"BME680_FILTER_SIZE_0 UINT8_C(0)\000"
.LASF420:
	.ascii	"__thumb2__ 1\000"
.LASF550:
	.ascii	"__RAL_WCHAR_T_DEFINED \000"
.LASF502:
	.ascii	"UINT_FAST8_MAX UINT8_MAX\000"
.LASF887:
	.ascii	"heatr_res_x100\000"
.LASF440:
	.ascii	"__ARM_PCS_VFP 1\000"
.LASF87:
	.ascii	"__WINT_WIDTH__ 32\000"
.LASF292:
	.ascii	"__ULLFRACT_MIN__ 0.0ULLR\000"
.LASF430:
	.ascii	"__ARM_FP16_ARGS\000"
.LASF16:
	.ascii	"__SIZEOF_INT__ 4\000"
.LASF286:
	.ascii	"__LLFRACT_IBIT__ 0\000"
.LASF529:
	.ascii	"__RAL_SIZE_T\000"
.LASF711:
	.ascii	"uint32_t\000"
.LASF865:
	.ascii	"get_mem_page\000"
.LASF744:
	.ascii	"int_n_sign_posn\000"
.LASF927:
	.ascii	"bme680_set_sensor_settings\000"
.LASF853:
	.ascii	"gas_sett\000"
.LASF517:
	.ascii	"UINT32_C(x) (x ##UL)\000"
.LASF299:
	.ascii	"__SACCUM_EPSILON__ 0x1P-7HK\000"
.LASF573:
	.ascii	"BME680_ADDR_RANGE_SW_ERR_ADDR UINT8_C(0x04)\000"
.LASF427:
	.ascii	"__ARM_FP 4\000"
.LASF62:
	.ascii	"__UINT_FAST16_TYPE__ unsigned int\000"
.LASF8:
	.ascii	"__VERSION__ \"9.3.1 20200408 (release)\"\000"
.LASF364:
	.ascii	"__UHA_IBIT__ 8\000"
.LASF784:
	.ascii	"__RAL_data_empty_string\000"
.LASF309:
	.ascii	"__ACCUM_EPSILON__ 0x1P-15K\000"
.LASF324:
	.ascii	"__ULACCUM_EPSILON__ 0x1P-32ULK\000"
.LASF576:
	.ascii	"BME680_FIELD0_ADDR UINT8_C(0x1d)\000"
.LASF177:
	.ascii	"__LDBL_DIG__ 15\000"
.LASF896:
	.ascii	"temp_scaled\000"
.LASF78:
	.ascii	"__WINT_MIN__ 0U\000"
.LASF613:
	.ascii	"BME680_RUN_GAS_DISABLE UINT8_C(0)\000"
.LASF207:
	.ascii	"__FLT64_DIG__ 15\000"
.LASF246:
	.ascii	"__DEC64_EPSILON__ 1E-15DD\000"
.LASF514:
	.ascii	"INT16_C(x) (x)\000"
.LASF108:
	.ascii	"__INT_LEAST8_WIDTH__ 8\000"
.LASF50:
	.ascii	"__INT_LEAST16_TYPE__ short int\000"
.LASF733:
	.ascii	"p_cs_precedes\000"
.LASF601:
	.ascii	"BME680_FILTER_SIZE_3 UINT8_C(2)\000"
.LASF184:
	.ascii	"__LDBL_MAX__ 1.1\000"
.LASF709:
	.ascii	"short unsigned int\000"
.LASF285:
	.ascii	"__LLFRACT_FBIT__ 63\000"
.LASF203:
	.ascii	"__FLT32_HAS_INFINITY__ 1\000"
.LASF603:
	.ascii	"BME680_FILTER_SIZE_15 UINT8_C(4)\000"
.LASF419:
	.ascii	"__thumb__ 1\000"
.LASF544:
	.ascii	"__CTYPE_GRAPH (__CTYPE_PUNCT | __CTYPE_UPPER | __CT"
	.ascii	"YPE_LOWER | __CTYPE_DIGIT)\000"
.LASF424:
	.ascii	"__ARMEL__ 1\000"
.LASF555:
	.ascii	"BME680_CHIP_ID UINT8_C(0x61)\000"
.LASF337:
	.ascii	"__HQ_FBIT__ 15\000"
.LASF577:
	.ascii	"BME680_RES_HEAT0_ADDR UINT8_C(0x5a)\000"
.LASF80:
	.ascii	"__SIZE_MAX__ 0xffffffffU\000"
.LASF580:
	.ascii	"BME680_CONF_ODR_RUN_GAS_NBC_ADDR UINT8_C(0x71)\000"
.LASF566:
	.ascii	"BME680_E_INVALID_LENGTH INT8_C(-4)\000"
.LASF559:
	.ascii	"BME680_FIELD_LENGTH UINT8_C(15)\000"
.LASF667:
	.ascii	"BME680_P7_REG (15)\000"
.LASF590:
	.ascii	"BME680_DISABLE_HEATER UINT8_C(0x08)\000"
.LASF416:
	.ascii	"__ARM_ARCH\000"
.LASF73:
	.ascii	"__LONG_MAX__ 0x7fffffffL\000"
.LASF619:
	.ascii	"BME680_OST_SEL UINT16_C(1)\000"
.LASF659:
	.ascii	"BME680_P1_MSB_REG (6)\000"
.LASF713:
	.ascii	"int64_t\000"
.LASF407:
	.ascii	"__ARM_FEATURE_LDREX 7\000"
.LASF892:
	.ascii	"lookupTable2\000"
.LASF289:
	.ascii	"__LLFRACT_EPSILON__ 0x1P-63LLR\000"
.LASF640:
	.ascii	"BME680_RSERROR_MSK UINT8_C(0xf0)\000"
.LASF258:
	.ascii	"__SFRACT_MAX__ 0X7FP-7HR\000"
.LASF220:
	.ascii	"__FLT32X_MANT_DIG__ 53\000"
.LASF512:
	.ascii	"INT8_C(x) (x)\000"
.LASF86:
	.ascii	"__WCHAR_WIDTH__ 32\000"
.LASF562:
	.ascii	"BME680_OK INT8_C(0)\000"
.LASF880:
	.ascii	"temp\000"
.LASF628:
	.ascii	"BME680_NBCONV_MIN UINT8_C(0)\000"
.LASF110:
	.ascii	"__INT16_C(c) c\000"
.LASF558:
	.ascii	"BME680_COEFF_ADDR2_LEN UINT8_C(16)\000"
.LASF780:
	.ascii	"__RAL_data_utf8_comma\000"
.LASF360:
	.ascii	"__DA_IBIT__ 32\000"
.LASF861:
	.ascii	"null_ptr_check\000"
.LASF816:
	.ascii	"par_gh3\000"
.LASF213:
	.ascii	"__FLT64_MAX__ 1.1\000"
.LASF338:
	.ascii	"__HQ_IBIT__ 0\000"
.LASF790:
	.ascii	"next\000"
.LASF588:
	.ascii	"BME680_SOFT_RESET_ADDR UINT8_C(0xe0)\000"
.LASF764:
	.ascii	"data\000"
.LASF631:
	.ascii	"BME680_NBCONV_MSK UINT8_C(0X0F)\000"
.LASF516:
	.ascii	"INT32_C(x) (x ##L)\000"
.LASF940:
	.ascii	"C:\\nordic\\nRF5_SDK_17.0.2_d674dde\\own_projects\\"
	.ascii	"eigene\\twi_sensor2\\pca10056\\blank\\ses\000"
.LASF843:
	.ascii	"heatr_temp\000"
.LASF552:
	.ascii	"BME680_POLL_PERIOD_MS UINT8_C(10)\000"
.LASF215:
	.ascii	"__FLT64_EPSILON__ 1.1\000"
.LASF92:
	.ascii	"__UINTMAX_MAX__ 0xffffffffffffffffULL\000"
.LASF532:
	.ascii	"__RAL_PTRDIFF_T int\000"
.LASF162:
	.ascii	"__DBL_MANT_DIG__ 53\000"
.LASF281:
	.ascii	"__ULFRACT_IBIT__ 0\000"
.LASF897:
	.ascii	"calc_hum\000"
.LASF794:
	.ascii	"bme680_com_fptr_t\000"
.LASF72:
	.ascii	"__INT_MAX__ 0x7fffffff\000"
.LASF52:
	.ascii	"__INT_LEAST64_TYPE__ long long int\000"
.LASF629:
	.ascii	"BME680_NBCONV_MAX UINT8_C(10)\000"
.LASF511:
	.ascii	"UINTPTR_MAX UINT32_MAX\000"
.LASF295:
	.ascii	"__SACCUM_FBIT__ 7\000"
.LASF644:
	.ascii	"BME680_GASM_VALID_MSK UINT8_C(0x20)\000"
.LASF808:
	.ascii	"par_h2\000"
.LASF776:
	.ascii	"__RAL_c_locale_abbrev_day_names\000"
.LASF490:
	.ascii	"UINT_LEAST8_MAX UINT8_MAX\000"
	.ident	"GCC: (GNU) 9.3.1 20200408 (release)"
